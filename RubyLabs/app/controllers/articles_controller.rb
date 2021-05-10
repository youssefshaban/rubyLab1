class ArticlesController < ApplicationController
  # before_action :require_jwt

  # def require_jwt
  #   token = request.headers["HTTP_AUTHORIZATION"]
  #   if !token
  #     head :forbidden
  #   end
  #   # if !valid_token(token)
  #   #   head :forbidden
  #   # end
  # end

  # private
  # def valid_token(token)
  #   unless token
  #     return false
  #   end

  #   token.gsub!('Bearer ','')
  #   begin
  #     decoded_token = JWT.decode token, Rails.configuration.x.oauth.jwt_secret, true
  #     return true
  #   rescue JWT::DecodeError
  #     Rails.logger.warn "Error decoding the JWT: "+ e.to_s
  #   end
  #   false
  # end


    def index
        @articles = Article.all
        authorize! :read, @articles
        # render json: { messages:  @articles }.to_json, status: :ok
    end
    def show
        @article = Article.find(params[:id])
        # render json: { messages:  @article }.to_json, status: :ok

    end
    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new(article_params)
    
        if @article.save
          redirect_to @article
        else
          render :new
        end
        
    end

    def edit
        @article = Article.find(params[:id])
      end
    
      def update
        @article = Article.find(params[:id])
    
        if @article.update(article_params)
          redirect_to @article
        else
          render :edit
        end
      end

      def destroy
        @article = Article.find(params[:id])
        @article.destroy
    
        redirect_to root_path
      end

    private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
