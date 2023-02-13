# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

config.vm.define "rpm" do |rpm|
rpm.vm.hostname = "rpm"
rpm.vm.provision "shell", path: "rpm.sh"
end

end
