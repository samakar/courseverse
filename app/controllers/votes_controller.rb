class VotesController < ApplicationController

  # GET /votes/new
  # GET /votes/new.xml
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # POST /votes
  # POST /votes.xml
  def create
    verse_id = params[:verse_id]
    vote = current_user.votes.build(verse_id: verse_id)
    respond_to do |format|
      if vote.save
        @votes_count = Verse.find(verse_id).votes.count 
        format.js { render :partial => 'create', :content_type => 'text/html'}
        format.html { redirect_to :back }
      else
        format.js
        format.html { redirect_to :back , flash: { error: "You can vote once per item." }}
      end
    end
  end
end