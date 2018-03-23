require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    # Build image before running tests
    @image = Docker::Image.build_from_dir('.')
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, @image.id
  end

  it "should exist" do
    expect(@image).to_not be_nil
  end

  describe 'Dockerfile#config' do
    it 'should expose port 4000' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to include('4000/tcp')
    end

    it 'should have a useruid of 1000' do
      expect(@image.json['ContainerConfig']["User"]).to eq("1000")
    end

    it 'should have a workingdir of /usr/src/app' do
      expect(@image.json['ContainerConfig']['WorkingDir']).to eq('/usr/src/app')
    end

    describe file('/usr/src/app/server.js') do
      it { should be_file }
    end
  end
end
