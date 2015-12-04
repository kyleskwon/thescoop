class ApplicationPolicy
  attr_reader :user, :record
  after_initialize :defaults

  def initialize(user, record)
    @user = user
    @record = record
  end

  def defaults
    self.role ||= :member
  end

  enum role: [:member, :premium, :admin]

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end