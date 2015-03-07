class StaticPagesController < ApplicationController
  layout :resolve_layout

  def home
  end

  def help
  end

  def faq
  end

  def about
  end

  def ldap
  end

  def not_found
    render :status => 404
  end

  def unacceptable
    render :status => 422
  end

  def internal_error
    render :status => 500
  end

  
  private
  def resolve_layout
    case action_name
      when 'home'
        'static-pages-layout'
      else
        'thesis2/thesis2'
    end
  end

end
