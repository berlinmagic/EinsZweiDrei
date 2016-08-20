# encoding: utf-8
module FiniteStateMachine
  extend ActiveSupport::Concern

  ## MicroMachine .. (Finite State Machine)
  #
  ## just: 
  #
  # include FiniteStateMachine
  #
  ## in each model you want and add your machine definition like so:
  #
  # def machine
  #   @machine ||= begin
  #     fsm = MicroMachine.new(fsm_state || "new")
  #     ...
  #     fsm
  #   end
  # end
  
  included do
    scope :actives,     ->          { where(fsm_state: "active") }
    scope :by_state,    -> (state)  { where(fsm_state: state) }
  end
  

  # =====> I N S T A N C E - M E T H O D S <================================================= #
  def fsm_trigger!( transition )
    machine.trigger( transition.to_sym )
    ## no callbacks
    # => update_column :fsm_state, machine.state
    ## with callbacks
    self.save if self.changed?
  end
  alias_method :trigger!,       :fsm_trigger!
  alias_method :do_transition!, :fsm_trigger!

  def fsm_trigger?( transition )
    machine.trigger?( transition.to_sym )
  end
  alias_method :trigger?,         :fsm_trigger?
  alias_method :can_transition?,  :fsm_trigger?

  def fsm_trigger( transition )
    machine.trigger( transition.to_sym )
  end
  
  ## fsm_state
  def state
    self.fsm_state || machine.state
  end
  alias_method :get_state,  :state
  
  
  
# => private


end