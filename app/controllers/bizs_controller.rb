class BizsController < ApplicationController

  def search
    @sort_type = params[:sort_type]
    @key = params[:key]

    if @sort_type == '1'
      #@bizs = Biz.order("rate ASC")
      @bizs = Biz.find_by_sql("select * from bizs where name like '%"+@key+"%' ")
    elsif @sort_type == '2'
      @bizs = Biz.find_by_sql("select * from bizs where name like '%"+@key+"%' order by rate DESC ")
    end
  end


  def filter
    @key = params[:biz][:name]
    if @key.blank?
      @bizs = Biz.order("rate asc")
    else
      @bizs = Biz.find_by_sql("select * from bizs where name like '%"+@key+"%' ")
    end
  end

  def create
    @biz = params[:biz]

    @biz = JSON.parse(@biz)

    puts @biz

    @biz = Biz.new(@biz)
    @biz.save
    redirect_to :action => 'search'
  end

  # def download
  #   send_file "public/files" + params[:filename] unless params[:filename].blank?
  # end

end