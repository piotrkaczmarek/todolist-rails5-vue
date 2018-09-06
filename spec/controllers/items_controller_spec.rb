require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  describe '#index' do
    subject { get(:index) }

    context 'when there are items' do
      let!(:items) { 3.times.map { create(:item) } }

      it 'returns 200 status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'returns all items' do
        subject
        expect(json_response.count).to eq(3)
        expect(json_response.map {|item| item['body'] }).to eq(items.map(&:body))
      end
    end

    context 'when there is no items' do
      it 'returns 200 status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'returns empty array' do
        subject
        expect(json_response).to eq([])
      end
    end
  end

  describe '#create' do
    subject { post(:create, { params: { body: body } }) }

    context 'with valid data' do
      let(:body) { 'test item' }

      it 'returns 200 status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'creates an item' do
        expect { subject }.to change { Item.count }.by(1)
      end
    end

    context 'with blank body' do
      let(:body) { '' }

      it 'returns 422 status code' do
        subject
        expect(response.status).to eq(422)
      end

      it 'does not create an item' do
        expect { subject }.not_to change { Item.count }
      end
    end

    context 'without params' do
      subject { post(:create) }

      it 'returns 422 status code' do
        subject
        expect(response.status).to eq(422)
      end

      it 'does not create an item' do
        expect { subject }.not_to change { Item.count }
      end
    end
  end
end
