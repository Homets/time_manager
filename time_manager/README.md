# TimeManager

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
* creating rel/overlays/bin/server                                                                                                                          
* creating rel/overlays/bin/server.bat                                                                                                                      
* creating rel/overlays/bin/migrate                                                                                                                         
* creating rel/overlays/bin/migrate.bat                                                                                                                     
* creating lib/time_manager/release.ex                                                                                                                      
                                                                                                                                                            
15:07:55.427 [debug] Fetching latest image information from https://hub.docker.com/v2/namespaces/hexpm/repositories/elixir/tags?name=1.15.7-erlang-26.1.2-debian-bullseye-                                                                                                                                              
* creating Dockerfile                                                                                                                                       
* creating .dockerignore                                                                                                                                    
                                                                                                                                                            
Your application is ready to be deployed in a release!                                                                                                      
                                                                                                                                                            
See https://hexdocs.pm/mix/Mix.Tasks.Release.html for more information about Elixir releases.                                                               
                                                                                                                                                            
Using the generated Dockerfile, your release will be bundled into                                                                                           
a Docker image, ready for deployment on platforms that support Docker.                                                                                      
                                                                                                                                                            
For more information about deploying with Docker see                                                                                                        
https://hexdocs.pm/phoenix/releases.html#containers                                                                                                         
                                                                                                                                                            
Here are some useful release commands you can run in any release environment:                                                                               
                                                                                                                                                            
    # To build a release                                                                                                                                    
    mix release                                                                                                                                             
                                                                                                                                                            
    # To start your system with the Phoenix server running                                                                                                  
    _build/dev/rel/time_manager/bin/server                                                                                                                  
                                                                                                                                                            
    # To run migrations                                                                                                                                     
    _build/dev/rel/time_manager/bin/migrate                                                                                                                 
                                                                                                                                                            
Once the release is running you can connect to it remotely:                                                                                                 
                                                                                                                                                            
    _build/dev/rel/time_manager/bin/time_manager remote                                                                                                     
                                                                                                                                                            
To list all commands:                                                                                                                                       
                                                                                                                                                            
    _build/dev/rel/time_manager/bin/time_manager                                                                                                            
 