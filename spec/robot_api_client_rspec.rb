
require "/home/houdiya/Bureau/Test/robot_api_exam/app/controllers/robot_api_client.rb"
describe RobotApiClient do
    describe ".ReponseGet" do
      context "Format de donnes:json ou csv" do
        it "Resultat des donnees en json ou csv" do
          expect(RobotApiClient.new.ReponseGet("csv"))
        end
      end
    end
  end