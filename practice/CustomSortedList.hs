module CustomSortedList
( buildSL
, isEmptySL
, insertSL
, headSL
, tailSL
) where

Data SL a = SLHeader (a -> a -> Bool) (SL a)
			| SLItem a (SL a)
			| Nil

buildSL :: (a -> a -> Bool) -> SL a
buildSL f = SLHeader f Nil

isEmptySL :: SL a -> Bool
isEmptySL (SLHeader _ Nil) = True
isEmptySL (SLHeader _ _) = False

insertSL :: a -> SL a -> SL a
insertSL el (SLHeader f Nil) = SLHeader f (SLItem el Nil)
insertSL el (SLHeader f (SLItem fitem sl)) = SLHeader f (insertSLRec f el (SLItem fitem sl))
insertSLRec :: (a -> a -> Bool) -> a -> SL a -> SL a
insertSLRec f el Nil = SLItem el Nil
insertSLRec f el (SLItem fitem sl) = if (f el fitem)
										then SLItem el (SLItem fitem sl)
										else SLItem fitem (insertSLRec f el sl)

headSL :: SL a -> a
headSL (SLHeader _ Nil) = Nil
headSL (SLHeader _ (SLItem fitem sl)) = fitem

tailSL :: SL a -> SL a
tailSL (SLHeader _ Nil) = Nil
tailSL (SLHeader f (SLItem fitem sl)) = SLHeader f sl