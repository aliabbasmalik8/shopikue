class ProductPolicy < ApplicationPolicy

    def index?
        
    end
  
    def show?
        @user.is_admin
    end
  
    def create?
        @user.is_admin
    end
  
    def new?
        create?
    end
  
    def update?
        @user.is_admin
    end
  
    def edit?
       update?
    end
  
    def destroy?
        @user.is_admin
    end

end
  