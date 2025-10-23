# frozen_string_literal: true

MkdocsRails::Engine.routes.draw do
  get "/*path", to: "docs#show", format: false
  root to: "docs#show"
end
