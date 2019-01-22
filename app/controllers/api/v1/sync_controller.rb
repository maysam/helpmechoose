module Api
  module V1
    class SyncController < ApplicationController
      protect_from_forgery with: :null_session

      def index

        # Rails.application.eager_load!

        # ApplicationRecord.descendants.collect { |type| [type.name, type.name.constantize.last&.updated_at.to_i] }.to_h

        render json: ActiveRecord::Base.connection.tables.map {|model|   model.capitalize.singularize.camelize.constantize rescue nil }.compact.map{|a| [a.name, a.last&.created_at.to_i] }.to_h

      end

      # GET /moods/1
      # GET /moods/1.json
      def fetch
        model = params[:model]
        from = params[:from].to_i
        query = model.constantize.where("extract(epoch from created_at) > #{from}")
        query = model.constantize.where("created_at > '#{Time.at from}'")
        render json: query.to_json
      rescue StandardError => e
        render json: {message: e}
      end

      def post
        # Parameters: {"_json"=>[{"id"=>174, "mood"=>1, "recorded_at"=>1542737390471, "user_id"=>"117146315519293105694"}
        results = params['_json'].map { |e|
          user = User.find_by google_id: e['user_id']
          mood = user.moods.find_or_create_by client_id: e['id']
          mood.update_attributes status: e['mood'], sent_at: Time.now, recorded_at: e['recorded_at']
          {
            model: 'Mood',
            timestamp: mood.updated_at.to_i,
            server_id: mood.id,
            client_id: mood.client_id
          }
        }
        Rails.logger.info results
        render json: results
      rescue StandardError => e
        render json: {message: e}
      end

      # GET /moods/new
      def new
        @mood = Mood.new
      end

      # GET /moods/1/edit
      def edit
      end

      # POST /moods
      # POST /moods.json
      def create
        @mood = Mood.new(mood_params)

        respond_to do |format|
          if @mood.save
            format.html { redirect_to @mood, notice: 'Mood was successfully created.' }
            format.json { render :show, status: :created, location: @mood }
          else
            format.html { render :new }
            format.json { render json: @mood.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /moods/1
      # PATCH/PUT /moods/1.json
      def update
        respond_to do |format|
          if @mood.update(mood_params)
            format.html { redirect_to @mood, notice: 'Mood was successfully updated.' }
            format.json { render :show, status: :ok, location: @mood }
          else
            format.html { render :edit }
            format.json { render json: @mood.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /moods/1
      # DELETE /moods/1.json
      def destroy
        @mood.destroy
        respond_to do |format|
          format.html { redirect_to moods_url, notice: 'Mood was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_mood
          @mood = Mood.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def mood_params
          params.fetch(:mood, {})
        end
    end
  end
end
