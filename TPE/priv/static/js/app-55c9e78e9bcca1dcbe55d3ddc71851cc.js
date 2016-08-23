!function(){"use strict";var e="undefined"==typeof window?global:window;if("function"!=typeof e.require){var t={},n={},i={},o={}.hasOwnProperty,s="components/",r=function(e,t){var n=0;t&&(0===t.indexOf(s)&&(n=s.length),t.indexOf("/",n)>0&&(t=t.substring(n,t.indexOf("/",n))));var o=i[e+"/index.js"]||i[t+"/deps/"+e+"/index.js"];return o?s+o.substring(0,o.length-".js".length):e},u=/^\.\.?(\/|$)/,a=function(e,t){for(var n,i=[],o=(u.test(t)?e+"/"+t:t).split("/"),s=0,r=o.length;r>s;s++)n=o[s],".."===n?i.pop():"."!==n&&""!==n&&i.push(n);return i.join("/")},c=function(e){return e.split("/").slice(0,-1).join("/")},h=function(t){return function(n){var i=a(c(t),n);return e.require(i,t)}},l=function(e,t){var i={id:e,exports:{}};return n[e]=i,t(i.exports,h(e),i),i.exports},f=function(e,i){var s=a(e,".");if(null==i&&(i="/"),s=r(e,i),o.call(n,s))return n[s].exports;if(o.call(t,s))return l(s,t[s]);var u=a(s,"./index");if(o.call(n,u))return n[u].exports;if(o.call(t,u))return l(u,t[u]);throw new Error('Cannot find module "'+e+'" from "'+i+'"')};f.alias=function(e,t){i[t]=e},f.register=f.define=function(e,n){if("object"==typeof e)for(var i in e)o.call(e,i)&&(t[i]=e[i]);else t[e]=n},f.list=function(){var e=[];for(var n in t)o.call(t,n)&&e.push(n);return e},f.brunch=!0,f._cache=n,e.require=f}}(),function(){var e=(window,{assert:{},buffer:{},child_process:{},cluster:{},crypto:{},dgram:{},dns:{},events:{},fs:{},http:{},https:{},net:{},os:{},path:{},punycode:{},querystring:{},readline:{},repl:{},string_decoder:{},tls:{},tty:{},url:{},util:{},vm:{},zlib:{},process:{env:{}}}),t=(e.process,function(t,n){return function(i){return void 0!==n[i]&&(i=n[i]),i=i.replace(".js",""),-1===["assert","buffer","child_process","cluster","crypto","dgram","dns","events","fs","http","https","net","os","path","punycode","querystring","readline","repl","string_decoder","tls","tty","url","util","vm","zlib","process"].indexOf(i)?t(i):e[i]}});require.register("phoenix",function(e,n,i){t(function(e){return n(e.replace("./","phoenix/"))},{});!function(e){"use strict";function t(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}var n="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol?"symbol":typeof e},i=function(){function e(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}return function(t,n,i){return n&&e(t.prototype,n),i&&e(t,i),t}}();Object.defineProperty(e,"__esModule",{value:!0});var o="1.0.0",s={connecting:0,open:1,closing:2,closed:3},r=1e4,u={closed:"closed",errored:"errored",joined:"joined",joining:"joining"},a={close:"phx_close",error:"phx_error",join:"phx_join",reply:"phx_reply",leave:"phx_leave"},c={longpoll:"longpoll",websocket:"websocket"},h=function(){function e(n,i,o,s){t(this,e),this.channel=n,this.event=i,this.payload=o||{},this.receivedResp=null,this.timeout=s,this.timeoutTimer=null,this.recHooks=[],this.sent=!1}return i(e,[{key:"resend",value:function(e){this.timeout=e,this.cancelRefEvent(),this.ref=null,this.refEvent=null,this.receivedResp=null,this.sent=!1,this.send()}},{key:"send",value:function(){this.hasReceived("timeout")||(this.startTimeout(),this.sent=!0,this.channel.socket.push({topic:this.channel.topic,event:this.event,payload:this.payload,ref:this.ref}))}},{key:"receive",value:function(e,t){return this.hasReceived(e)&&t(this.receivedResp.response),this.recHooks.push({status:e,callback:t}),this}},{key:"matchReceive",value:function(e){var t=e.status,n=e.response;e.ref;this.recHooks.filter(function(e){return e.status===t}).forEach(function(e){return e.callback(n)})}},{key:"cancelRefEvent",value:function(){this.refEvent&&this.channel.off(this.refEvent)}},{key:"cancelTimeout",value:function(){clearTimeout(this.timeoutTimer),this.timeoutTimer=null}},{key:"startTimeout",value:function(){var e=this;this.timeoutTimer||(this.ref=this.channel.socket.makeRef(),this.refEvent=this.channel.replyEventName(this.ref),this.channel.on(this.refEvent,function(t){e.cancelRefEvent(),e.cancelTimeout(),e.receivedResp=t,e.matchReceive(t)}),this.timeoutTimer=setTimeout(function(){e.trigger("timeout",{})},this.timeout))}},{key:"hasReceived",value:function(e){return this.receivedResp&&this.receivedResp.status===e}},{key:"trigger",value:function(e,t){this.channel.trigger(this.refEvent,{status:e,response:t})}}]),e}(),l=e.Channel=function(){function e(n,i,o){var s=this;t(this,e),this.state=u.closed,this.topic=n,this.params=i||{},this.socket=o,this.bindings=[],this.timeout=this.socket.timeout,this.joinedOnce=!1,this.joinPush=new h(this,a.join,this.params,this.timeout),this.pushBuffer=[],this.rejoinTimer=new d(function(){return s.rejoinUntilConnected()},this.socket.reconnectAfterMs),this.joinPush.receive("ok",function(){s.state=u.joined,s.rejoinTimer.reset(),s.pushBuffer.forEach(function(e){return e.send()}),s.pushBuffer=[]}),this.onClose(function(){s.socket.log("channel","close "+s.topic),s.state=u.closed,s.socket.remove(s)}),this.onError(function(e){s.socket.log("channel","error "+s.topic,e),s.state=u.errored,s.rejoinTimer.scheduleTimeout()}),this.joinPush.receive("timeout",function(){s.state===u.joining&&(s.socket.log("channel","timeout "+s.topic,s.joinPush.timeout),s.state=u.errored,s.rejoinTimer.scheduleTimeout())}),this.on(a.reply,function(e,t){s.trigger(s.replyEventName(t),e)})}return i(e,[{key:"rejoinUntilConnected",value:function(){this.rejoinTimer.scheduleTimeout(),this.socket.isConnected()&&this.rejoin()}},{key:"join",value:function(){var e=arguments.length<=0||void 0===arguments[0]?this.timeout:arguments[0];if(this.joinedOnce)throw"tried to join multiple times. 'join' can only be called a single time per channel instance";return this.joinedOnce=!0,this.rejoin(e),this.joinPush}},{key:"onClose",value:function(e){this.on(a.close,e)}},{key:"onError",value:function(e){this.on(a.error,function(t){return e(t)})}},{key:"on",value:function(e,t){this.bindings.push({event:e,callback:t})}},{key:"off",value:function(e){this.bindings=this.bindings.filter(function(t){return t.event!==e})}},{key:"canPush",value:function(){return this.socket.isConnected()&&this.state===u.joined}},{key:"push",value:function(e,t){var n=arguments.length<=2||void 0===arguments[2]?this.timeout:arguments[2];if(!this.joinedOnce)throw"tried to push '"+e+"' to '"+this.topic+"' before joining. Use channel.join() before pushing events";var i=new h(this,e,t,n);return this.canPush()?i.send():(i.startTimeout(),this.pushBuffer.push(i)),i}},{key:"leave",value:function(){var e=this,t=arguments.length<=0||void 0===arguments[0]?this.timeout:arguments[0],n=function(){e.socket.log("channel","leave "+e.topic),e.trigger(a.close,"leave")},i=new h(this,a.leave,{},t);return i.receive("ok",function(){return n()}).receive("timeout",function(){return n()}),i.send(),this.canPush()||i.trigger("ok",{}),i}},{key:"onMessage",value:function(e,t,n){}},{key:"isMember",value:function(e){return this.topic===e}},{key:"sendJoin",value:function(e){this.state=u.joining,this.joinPush.resend(e)}},{key:"rejoin",value:function(){var e=arguments.length<=0||void 0===arguments[0]?this.timeout:arguments[0];this.sendJoin(e)}},{key:"trigger",value:function(e,t,n){this.onMessage(e,t,n),this.bindings.filter(function(t){return t.event===e}).map(function(e){return e.callback(t,n)})}},{key:"replyEventName",value:function(e){return"chan_reply_"+e}}]),e}(),f=(e.Socket=function(){function e(n){var i=this,o=arguments.length<=1||void 0===arguments[1]?{}:arguments[1];t(this,e),this.stateChangeCallbacks={open:[],close:[],error:[],message:[]},this.channels=[],this.sendBuffer=[],this.ref=0,this.timeout=o.timeout||r,this.transport=o.transport||window.WebSocket||f,this.heartbeatIntervalMs=o.heartbeatIntervalMs||3e4,this.reconnectAfterMs=o.reconnectAfterMs||function(e){return[1e3,2e3,5e3,1e4][e-1]||1e4},this.logger=o.logger||function(){},this.longpollerTimeout=o.longpollerTimeout||2e4,this.params=o.params||{},this.endPoint=n+"/"+c.websocket,this.reconnectTimer=new d(function(){i.disconnect(function(){return i.connect()})},this.reconnectAfterMs)}return i(e,[{key:"protocol",value:function(){return location.protocol.match(/^https/)?"wss":"ws"}},{key:"endPointURL",value:function(){var e=p.appendParams(p.appendParams(this.endPoint,this.params),{vsn:o});return"/"!==e.charAt(0)?e:"/"===e.charAt(1)?this.protocol()+":"+e:this.protocol()+"://"+location.host+e}},{key:"disconnect",value:function(e,t,n){this.conn&&(this.conn.onclose=function(){},t?this.conn.close(t,n||""):this.conn.close(),this.conn=null),e&&e()}},{key:"connect",value:function(e){var t=this;e&&(console&&console.log("passing params to connect is deprecated. Instead pass :params to the Socket constructor"),this.params=e),this.conn||(this.conn=new this.transport(this.endPointURL()),this.conn.timeout=this.longpollerTimeout,this.conn.onopen=function(){return t.onConnOpen()},this.conn.onerror=function(e){return t.onConnError(e)},this.conn.onmessage=function(e){return t.onConnMessage(e)},this.conn.onclose=function(e){return t.onConnClose(e)})}},{key:"log",value:function(e,t,n){this.logger(e,t,n)}},{key:"onOpen",value:function(e){this.stateChangeCallbacks.open.push(e)}},{key:"onClose",value:function(e){this.stateChangeCallbacks.close.push(e)}},{key:"onError",value:function(e){this.stateChangeCallbacks.error.push(e)}},{key:"onMessage",value:function(e){this.stateChangeCallbacks.message.push(e)}},{key:"onConnOpen",value:function(){var e=this;this.log("transport","connected to "+this.endPointURL(),this.transport.prototype),this.flushSendBuffer(),this.reconnectTimer.reset(),this.conn.skipHeartbeat||(clearInterval(this.heartbeatTimer),this.heartbeatTimer=setInterval(function(){return e.sendHeartbeat()},this.heartbeatIntervalMs)),this.stateChangeCallbacks.open.forEach(function(e){return e()})}},{key:"onConnClose",value:function(e){this.log("transport","close",e),this.triggerChanError(),clearInterval(this.heartbeatTimer),this.reconnectTimer.scheduleTimeout(),this.stateChangeCallbacks.close.forEach(function(t){return t(e)})}},{key:"onConnError",value:function(e){this.log("transport",e),this.triggerChanError(),this.stateChangeCallbacks.error.forEach(function(t){return t(e)})}},{key:"triggerChanError",value:function(){this.channels.forEach(function(e){return e.trigger(a.error)})}},{key:"connectionState",value:function(){switch(this.conn&&this.conn.readyState){case s.connecting:return"connecting";case s.open:return"open";case s.closing:return"closing";default:return"closed"}}},{key:"isConnected",value:function(){return"open"===this.connectionState()}},{key:"remove",value:function(e){this.channels=this.channels.filter(function(t){return!t.isMember(e.topic)})}},{key:"channel",value:function(e){var t=arguments.length<=1||void 0===arguments[1]?{}:arguments[1],n=new l(e,t,this);return this.channels.push(n),n}},{key:"push",value:function(e){var t=this,n=e.topic,i=e.event,o=e.payload,s=e.ref,r=function(){return t.conn.send(JSON.stringify(e))};this.log("push",n+" "+i+" ("+s+")",o),this.isConnected()?r():this.sendBuffer.push(r)}},{key:"makeRef",value:function(){var e=this.ref+1;return e===this.ref?this.ref=0:this.ref=e,this.ref.toString()}},{key:"sendHeartbeat",value:function(){this.isConnected()&&this.push({topic:"phoenix",event:"heartbeat",payload:{},ref:this.makeRef()})}},{key:"flushSendBuffer",value:function(){this.isConnected()&&this.sendBuffer.length>0&&(this.sendBuffer.forEach(function(e){return e()}),this.sendBuffer=[])}},{key:"onConnMessage",value:function(e){var t=JSON.parse(e.data),n=t.topic,i=t.event,o=t.payload,s=t.ref;this.log("receive",(o.status||"")+" "+n+" "+i+" "+(s&&"("+s+")"||""),o),this.channels.filter(function(e){return e.isMember(n)}).forEach(function(e){return e.trigger(i,o,s)}),this.stateChangeCallbacks.message.forEach(function(e){return e(t)})}}]),e}(),e.LongPoll=function(){function e(n){t(this,e),this.endPoint=null,this.token=null,this.skipHeartbeat=!0,this.onopen=function(){},this.onerror=function(){},this.onmessage=function(){},this.onclose=function(){},this.pollEndpoint=this.normalizeEndpoint(n),this.readyState=s.connecting,this.poll()}return i(e,[{key:"normalizeEndpoint",value:function(e){return e.replace("ws://","http://").replace("wss://","https://").replace(new RegExp("(.*)/"+c.websocket),"$1/"+c.longpoll)}},{key:"endpointURL",value:function(){return p.appendParams(this.pollEndpoint,{token:this.token})}},{key:"closeAndRetry",value:function(){this.close(),this.readyState=s.connecting}},{key:"ontimeout",value:function(){this.onerror("timeout"),this.closeAndRetry()}},{key:"poll",value:function(){var e=this;(this.readyState===s.open||this.readyState===s.connecting)&&p.request("GET",this.endpointURL(),"application/json",null,this.timeout,this.ontimeout.bind(this),function(t){if(t){var n=t.status,i=t.token,o=t.messages;e.token=i}else var n=0;switch(n){case 200:o.forEach(function(t){return e.onmessage({data:JSON.stringify(t)})}),e.poll();break;case 204:e.poll();break;case 410:e.readyState=s.open,e.onopen(),e.poll();break;case 0:case 500:e.onerror(),e.closeAndRetry();break;default:throw"unhandled poll status "+n}})}},{key:"send",value:function(e){var t=this;p.request("POST",this.endpointURL(),"application/json",e,this.timeout,this.onerror.bind(this,"timeout"),function(e){e&&200===e.status||(t.onerror(status),t.closeAndRetry())})}},{key:"close",value:function(e,t){this.readyState=s.closed,this.onclose()}}]),e}()),p=e.Ajax=function(){function e(){t(this,e)}return i(e,null,[{key:"request",value:function(e,t,n,i,o,s,r){if(window.XDomainRequest){var u=new XDomainRequest;this.xdomainRequest(u,e,t,i,o,s,r)}else{var u=window.XMLHttpRequest?new XMLHttpRequest:new ActiveXObject("Microsoft.XMLHTTP");this.xhrRequest(u,e,t,n,i,o,s,r)}}},{key:"xdomainRequest",value:function(e,t,n,i,o,s,r){var u=this;e.timeout=o,e.open(t,n),e.onload=function(){var t=u.parseJSON(e.responseText);r&&r(t)},s&&(e.ontimeout=s),e.onprogress=function(){},e.send(i)}},{key:"xhrRequest",value:function(e,t,n,i,o,s,r,u){var a=this;e.timeout=s,e.open(t,n,!0),e.setRequestHeader("Content-Type",i),e.onerror=function(){u&&u(null)},e.onreadystatechange=function(){if(e.readyState===a.states.complete&&u){var t=a.parseJSON(e.responseText);u(t)}},r&&(e.ontimeout=r),e.send(o)}},{key:"parseJSON",value:function(e){return e&&""!==e?JSON.parse(e):null}},{key:"serialize",value:function(e,t){var i=[];for(var o in e)if(e.hasOwnProperty(o)){var s=t?t+"["+o+"]":o,r=e[o];"object"===("undefined"==typeof r?"undefined":n(r))?i.push(this.serialize(r,s)):i.push(encodeURIComponent(s)+"="+encodeURIComponent(r))}return i.join("&")}},{key:"appendParams",value:function(e,t){if(0===Object.keys(t).length)return e;var n=e.match(/\?/)?"&":"?";return""+e+n+this.serialize(t)}}]),e}();p.states={complete:4};var d=function(){function e(n,i){t(this,e),this.callback=n,this.timerCalc=i,this.timer=null,this.tries=0}return i(e,[{key:"reset",value:function(){this.tries=0,clearTimeout(this.timer)}},{key:"scheduleTimeout",value:function(){var e=this;clearTimeout(this.timer),this.timer=setTimeout(function(){e.tries=e.tries+1,e.callback()},this.timerCalc(this.tries+1))}}]),e}()}("undefined"==typeof e?window.Phoenix=window.Phoenix||{}:e)}),require.register("phoenix_html",function(e,n,i){t(function(e){return n(e.replace("./","phoenix_html/"))},{});window.addEventListener("click",function(e){if(e.target&&e.target.matches("a[data-submit=parent]")){var t=e.target.getAttribute("data-confirm");return(null===t||confirm(t))&&e.target.parentNode.submit(),e.preventDefault(),!1}},!1)})}(),require.register("web/static/js/app",function(e,t,n){"use strict";t("phoenix_html")}),require.register("web/static/js/socket",function(e,t,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var i=t("phoenix"),o=new i.Socket("/socket",{params:{token:window.userToken}});o.connect();var s=o.channel("topic:subtopic",{});s.join().receive("ok",function(e){console.log("Joined successfully",e)}).receive("error",function(e){console.log("Unable to join",e)}),e["default"]=o}),require("web/static/js/app");