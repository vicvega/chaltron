class HomeController < ApplicationController

  def index
  end

  Array(1..10).each do |x|
    define_method "test#{x}" do
      @test = x
      render :test
    end
  end

end
