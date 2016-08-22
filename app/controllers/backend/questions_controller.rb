# encoding: utf-8
class Backend::QuestionsController < Backend::BaseController
  
  before_action :fetch_resource, only: [ :show, :edit, :update, :destroy ]
  
  def index
    # @questions = Question.all
    @questions = current_user.questions.all
  end
  
  def show
  end
  
  def new
    @question = ::Question.new( )
    render :form
  end
  
  def create
    @question = ::Question.new( resource_params.merge( user: current_user) )
    if @question.save
      redirect_to resource_domain, notice: I18n.t("messages.create_success", model: one_name)
    else
      redirect_to resource_domain, alert: I18n.t("messages.create_error", model: one_name)
    end
  end
  
  def edit
    render :form
  end
  
  
  def update
    if @question.update( resource_params )
      redirect_to resource_domain, notice: I18n.t("messages.update_success", model: one_name)
    else
      redirect_to resource_domain, alert: I18n.t("messages.update_error", model: one_name)
    end
  end
  
  def destroy
    @question.destroy
    redirect_to :back, notice: I18n.t("messages.delete_success", model: one_name)
  end
  
  def sort
    Rails.logger.info "***********************"
    Rails.logger.info JSON.parse( params[:sort] ).join(" .. ")
    Rails.logger.info "***********************"
    JSON.parse( params[:sort] ).each_with_index do |that,index|
      # => @featured = ::Prdcts::Featured.find( that.to_i )
      # => @featured.position = index + 1
      # => @featured.save
      category = ::Question.find( that.to_i )
      category.position = index + 1
      category.save
      
      Rails.logger.info " >>> #{that.to_i}  =>  #{index + 1}"
    end
    render nothing: true
  end
  
  def build_samples
    current_user.questions.create!(
      text:     "Wofür steht Mexico?",
      answer1:  "Maultaschen",
      answer2:  "Mangos",
      answer3:  "Mayas",
      result:   3
    )
    current_user.questions.create!(
      text:     "Wie viele Tage hat ein Jahr?",
      answer1:  "365",
      answer2:  "366",
      answer3:  "356",
      result:   1
    )
    current_user.questions.create!(
      text:     "Mit welcher Einheit wird elektrische Spannung gemessen?",
      answer1:  "Watt",
      answer2:  "Ampere",
      answer3:  "Volt",
      result:   3
    )
    current_user.questions.create!(
      text:     "Wie viele Nullen hat eine Billiarde?",
      answer1:  "12",
      answer2:  "15",
      answer3:  "18",
      result:   2
    )
    redirect_to resource_domain, notice: "Beispiel Fragen wurden erstellt!"
  end
  
  
private
  
    def fetch_resource
      # @question = ::Question.find( params[:id] )
      @question = current_user.questions.find( params[:id] )
    end
    
    def resource_params
      params.require( :question ).permit( :text, :answer1, :answer2, :answer3, :result )
    end
    
    def resource_domain
      app_questions_path
    end
    
    def one_name
      I18n.t("activerecord.attributes.question.one")
    end
  
  
end
