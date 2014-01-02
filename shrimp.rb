class Shrimp
  def initialize(app)
    @app = app       
  end                

  def call(env)      
    status, headers, body = @app.call(env)
    puts headers.inspect
    [status, headers, body]
  end                
end                  

