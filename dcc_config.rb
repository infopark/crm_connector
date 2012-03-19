send_notifications_to "stefan.krause@infopark.de", "kai-uwe.humpert@infopark.de"

depends_upon.project "git@github.com:infopark/omc.git"

buckets "tests" do
  bucket("ruby").performs_rake_tasks("test:ruby")
end
