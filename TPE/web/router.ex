defmodule Connecton.Router do
  use Connecton.Web, :router
  import Connecton.Session, only: [load_current_user: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug :load_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Connecton do
    pipe_through [:browser, :browser_auth]

    get "/", PageController, :index
    post "/login", UserSessionController, :login
    delete "/logout", UserSessionController, :logout
    resources "/users", UserController, only: [:show, :index, :create, :edit, :update]
    resources "/posts", PostController
    resources "/job_offers", JobOfferController do
      post "/apply_from_posts", JobApplicationController, :apply_from_posts
      post "/close", JobOfferController, :close
      post "/activate", JobOfferController, :activate
    end
    resources "/job_applications", JobApplicationController, only: [:delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Connecton do
  #   pipe_through :api
  # end
end
