defmodule WdpaPhoenix.Router do
  use WdpaPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WdpaPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/countries", CountryController
    resources "/protected_areas", ProtectedAreaController
  end


  # Other scopes may use custom stacks.
  scope "/api", WdpaPhoenix do
    pipe_through :api

    resources "/designation_types", DesignationTypeController, except: [:new, :edit]
    resources "/designations",      DesignationController,     except: [:new, :edit]
  end
end
