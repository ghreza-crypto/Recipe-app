class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:

    return unless user.present?

    if user.nil?
      can :read, Food
    else
      can %i[read create], Food
      can %i[read create], Recipe
      can %i[read create], RecipeFood
      can %i[update destroy], Food, user_id: user.id
      can %i[update destroy], Recipe, user_id: user.id
      can %i[update destroy], RecipeFood, user_id: user.id
    end

    # <% if can? :manage, @question %>
    #   <%= link_to 'Edit', edit_question_path(@question) %> | <%= link_to 'Destroy', @question, method: :delete, data: { confirm: 'Are you sure you want to delete this job?' } %>
    # <% end %>

    # return unless user.present?

    # can :read, :all
    # can :create, [Food, Recipe, RecipeFood]
    # can :destroy, [Food, Recipe, RecipeFood]

    # if user.role == 'admin'
    #   can :manage, :all
    # else
    #   can :destroy, Food, author: user
    #   can :destroy, Recipe, author: user
    #   can :destroy, RecipeFood, author: user
    # end
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end