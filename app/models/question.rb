# encoding: utf-8
class Question < ActiveRecord::Base
  
  # =====> R E W R I T E S <================================================================= #
  
  # =====> C O N S T A N T S <=============================================================== #
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  
  # =====> A T T R I B U T E S <============================================================= #
  
  # =====> V A L I D A T I O N <============================================================= #
  validates :text, :answer1, :answer2, :answer3, presence: true
  validates :result, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  
  
  # =====> C A L L B A C K S <=============================================================== #
  before_create :set_position
  
  
  # =====> S C O P E S <===================================================================== #
  default_scope { order(:position) } 
  
  
  # =====> C L A S S - M E T H O D S <======================================================= #
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
  
  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
private
  
  def set_position
    self.position = Question.any? ? (Question.last.position + 1) : 1
  end
  
end
