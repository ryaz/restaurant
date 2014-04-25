require 'spec_helper'
describe ReservationsController do

  let(:valid_attributes) { { "start_time" => "2014-04-24 17:06:36", "end_time" => "2014-04-25 17:06:36", "table_id" => 1 } }
  let(:another_valid_attributes) { { "start_time" => "2014-04-21 17:06:36", "end_time" => "2014-04-22 17:06:36", "table_id" => 1 } }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all reservations as @reservations" do
      reservation = Reservation.create! valid_attributes
      get :index, {}, valid_session
      assigns(:reservations).should eq([reservation])
    end
  end

  describe "GET show" do
    it "assigns the requested reservation as @reservation" do
      reservation = Reservation.create! valid_attributes
      get :show, {:id => reservation.to_param}, valid_session
      assigns(:reservation).should eq(reservation)
    end
  end

  describe "GET new" do
    it "assigns a new reservation as @reservation" do
      get :new, {}, valid_session
      assigns(:reservation).should be_a_new(Reservation)
    end
  end

  describe "GET edit" do
    it "assigns the requested reservation as @reservation" do
      reservation = Reservation.create! valid_attributes
      get :edit, {:id => reservation.to_param}, valid_session
      assigns(:reservation).should eq(reservation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Reservation" do
        expect {
          post :create, {:reservation => valid_attributes}, valid_session
        }.to change(Reservation, :count).by(1)
      end

      it "assigns a newly created reservation as @reservation" do
        post :create, {:reservation => valid_attributes}, valid_session
        assigns(:reservation).should be_a(Reservation)
        assigns(:reservation).should be_persisted
      end

      it "redirects to the created reservation" do
        post :create, {:reservation => valid_attributes}, valid_session
        response.should redirect_to(Reservation.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved reservation as @reservation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reservation.any_instance.stub(:save).and_return(false)
        post :create, {:reservation => { "start_time" => "invalid value" }}, valid_session
        assigns(:reservation).should be_a_new(Reservation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reservation.any_instance.stub(:save).and_return(false)
        post :create, {:reservation => { "start_time" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested reservation" do
        reservation = Reservation.create! valid_attributes
        Reservation.any_instance.should_receive(:update).with({ "start_time" => "2014-04-24 17:06:36" })
        put :update, {:id => reservation.to_param, :reservation => { "start_time" => "2014-04-24 17:06:36" }}, valid_session
      end

      it "assigns the requested reservation as @reservation" do
        reservation = Reservation.create! valid_attributes
        put :update, {:id => reservation.to_param, :reservation => valid_attributes}, valid_session
        assigns(:reservation).should eq(reservation)
      end

      it "redirects to the reservation" do
        reservation = Reservation.create! valid_attributes
        put :update, {:id => reservation.to_param, :reservation => another_valid_attributes}, valid_session
        response.should redirect_to(reservation)
      end
    end

    describe "with invalid params" do
      it "assigns the reservation as @reservation" do
        reservation = Reservation.create! valid_attributes
        Reservation.any_instance.stub(:save).and_return(false)
        put :update, {:id => reservation.to_param, :reservation => { "start_time" => "invalid value" }}, valid_session
        assigns(:reservation).should eq(reservation)
      end

      it "re-renders the 'edit' template" do
        reservation = Reservation.create! valid_attributes
        Reservation.any_instance.stub(:save).and_return(false)
        put :update, {:id => reservation.to_param, :reservation => { "start_time" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested reservation" do
      reservation = Reservation.create! valid_attributes
      expect {
        delete :destroy, {:id => reservation.to_param}, valid_session
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the reservations list" do
      reservation = Reservation.create! valid_attributes
      delete :destroy, {:id => reservation.to_param}, valid_session
      response.should redirect_to(reservations_url)
    end
  end

end