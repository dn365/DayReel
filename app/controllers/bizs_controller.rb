class BizsController < ApplicationController

  def search
    @sort_type = params[:sort_type]
    @key = params[:key]

    # @filter = params[:biz] ? params[:biz][:company_name] : nil

    if !@key.empty?
      @bizs = if @sort_type == '1'
         Biz.find_by_sql("select * from bizs where company_name like '%"+@key+"%' ")
      elsif @sort_type == '2'
        Biz.find_by_sql("select * from bizs where company_name like '%"+@key+"%' order by rate DESC ")
      else
        Biz.find_by_sql("select * from bizs where company_name like '%"+@key+"%' ")
      end
    else
      @bizs = if @sort_type == '1'
                Biz.order("rate ASC")
              elsif @sort_type == '2'
                Biz.order("rate DESC")
              else
                Biz.order("rate ASC")
              end


    end

  end


  # def filter
  #
  #   if @key.blank?
  #     @bizs = Biz.order("rate asc")
  #   else
  #     @bizs = Biz.find_by_sql("select * from bizs where company_name like '%"+@key+"%' ")
  #   end
  #
  # end

  def create
    @biz = params[:biz]

    @biz = JSON.parse(@biz)

    puts @biz

    @biz = Biz.new(@biz)
    if @biz.save
    # redirect_to :action => 'search'

      render json: {url: @biz.url}
    else
      render json: {error: "---"}
    end


  end

  # def download
  #   send_file "public/files" + params[:filename] unless params[:filename].blank?
  # end

end