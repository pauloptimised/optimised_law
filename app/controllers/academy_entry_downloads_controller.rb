class AcademyEntryDownloadsController < ApplicationController
  before_action :set_academy_entry

  def create
    @academy_entry_download = AcademyEntryDownload.new(academy_entry_download_params)
    @academy_entry_download.academy_entry_id = @academy_entry.id
    if @academy_entry_download.save
      AcademyEntriesMailer.new_resource(@academy_entry, @academy_entry_download).deliver_now
      redirect_to thank_you_academy_entry_path(@academy_entry)
    else
      render 'academy_entries/show'
    end
  end

  def show
    @marketing_assessment_signup = MarketingAssessmentSignup.new
  end

  private

    def set_academy_entry
      @academy_entry = AcademyEntry.where(display: true).friendly.find(params[:id])
    end

    def academy_entry_download_params
      params.require(:academy_entry_download).permit(:forename, :surname, :email)
    end
end
