class ProgramingLanguagesController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render json: [
      {
        "code": "ruby",
        "displayName": "Ruby"
      },
      {
        "code": "python",
        "displayName": "Python"
      },
      {
        "code": "java",
        "displayName": "Java"
      }
    ]
  end
end
