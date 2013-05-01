require 'rubygems'
require 'nokogiri'
require 'open-uri'


class HomeController < ApplicationController
  def index
  end
  
  def extract_images
    
    
    puts "THe url: #{params[:url]}"
    if params[:url].present?
      begin
        
        puts "Gonna call nokogiri"
        page = Nokogiri::HTML(open( params[:url]  ))  
        puts "After nokogiri"
        
        puts "The page is opened" if page 
      
        if params[:url] =~ /imgur.com/
          
          if( page.css("#image-container").length == 0 )
            if( page.css("#image").length != 0 )
              result = page.css("#image img")
              images = result.map {|x| x['src'] }
            else
              result = page.css("#content div.main-image img")
              images = result.map {|x| x['src'] }
            end
          else
            result = page.css("#image-container img")
            images = result.map {|x| x['data-src'] }
          end
          
        elsif params[:url] =~ /weluvporn.com/
          
          if( page.css('.pictureImage img').length != 0  )
            result = page.css('.pictureImage img')
            images = result.map {|x| x['src'] }
          else
            result = page.css('#wlt-PictureOriginal img')
            images = result.map {|x| x['src'] }
          end
   
        elsif params[:url] =~ /thefreefap.com/
          
          result = page.css('.pictureImage img')
          images = result.map {|x| x['src'] }
   
        elsif params[:url] =~ /subimg.net/
          
          result = page.css('img.magnify')
          images = result.map {|x| x['src'] }
   
        end
        
        
        
        puts "Total images: #{images.count}"
        
        
        render :json=> {:success=>true, :images => images } 
      rescue 
        puts "in the rescue block"
        puts "The error: e.inspect"
        render :json=> {:success=>false, :message=>"Your link is INVALID"} 
      end
    else
      render :json=> {:success=>false, :message=>"Your link is not present"} 
    end
    
    
  end
end
