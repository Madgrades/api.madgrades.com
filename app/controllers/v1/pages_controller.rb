class V1::PagesController < ApiController
  def index

  end

  def revision
    @revision = `git rev-parse --short HEAD`
  end
end
