class OpensearchController < ApplicationController
def index
    respond_to do |format|
      format.xml
    end
  end
end
