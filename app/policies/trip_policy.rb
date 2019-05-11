class TripPolicy < ApplicationPolicy
   #trip policy created for a trip if the user is oner of that trip is not.If not then he is not authoriz to do it.
   class Scope
    attr_reader :user, :scope

       def initialize(user, scope)
         @user  = user
         @scope = scope
       end
    end
    
    
     def new? ; user_is_owner_of_record? ; end
     def create? ; user_is_owner_of_record? ; end

     def show?
       user_is_owner_of_record? 
     end

     def update? ; user_is_owner_of_record? ; end
     def destroy? ; user_is_owner_of_record? ; end
         
      private 
         def user_is_owner_of_record?
          @user == @record.user
         end
         
end