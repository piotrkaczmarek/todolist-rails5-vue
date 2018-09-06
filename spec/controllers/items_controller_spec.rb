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
    subject { post(:create, params: { body: body }) }

    context 'with valid data' do
      let(:body) { 'test item' }

      it 'returns 200 status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'creates an item' do
        expect { subject }.to change { Item.count }.by(1)
      end

      it 'returns created item' do
        subject
        expect(json_response['id']).to eq(Item.last.id)
        expect(json_response['body']).to eq(Item.last.body)
      end
    end

    context 'with blank body' do
      let(:body) { '' }

      it 'returns 400 status code' do
        subject
        expect(response.status).to eq(400)
      end

      it 'does not create an item' do
        expect { subject }.not_to change { Item.count }
      end
    end

    context 'without params' do
      subject { post(:create) }

      it 'returns 400 status code' do
        subject
        expect(response.status).to eq(400)
      end

      it 'does not create an item' do
        expect { subject }.not_to change { Item.count }
      end
    end
  end

  describe '#destroy' do
    subject { delete(:destroy, params: { id: id }) }

    context 'when item with given id exists' do
      let!(:item) { create(:item) }
      let(:id) { item.id }

      it 'returns 200 status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'deletes the item' do
        expect { subject }.to change { Item.count }.by(-1)
      end
    end

    context 'when item with given id does not exist' do
      let(:id) { 999 }

      it 'returns 404 status code' do
        subject
        expect(response.status).to eq(404)
      end

      it 'does not delete any item' do
        expect { subject }.not_to change { Item.count }
      end
    end
  end

  describe '#update' do
    let(:params) { { id: id, body: body } }

    subject { put(:update, params: params) }

    context 'when item exists' do
      let!(:item) { create(:item) }
      let(:id) { item.id }

      context 'when body in param is valid' do
        let(:body) { 'valid test data' }

        it 'returns 200' do
          subject
          expect(response.status).to eq(200)
        end

        it 'updates item\'s body' do
          expect { subject }.to change { item.reload.body }.to(body)
        end

        it 'does not change item count' do
          expect { subject }.not_to change { Item.count }
        end

        it 'returns updated item' do
          subject
          expect(json_response['id']).to eq(item.id)
          expect(json_response['body']).to eq(body)
        end
      end

      context 'when body in param is blank' do
        let(:body) { '' }

        it 'returns 400' do
          subject
          expect(response.status).to eq(400)
        end

        it 'does not update item\'s body' do
          expect { subject }.not_to change { item.reload.body }
        end

        it 'does not change item count' do
          expect { subject }.not_to change { Item.count }
        end
      end

      context 'when body in params is missing' do
        let(:body) { '' }

        before { params.delete(:body) }

        it 'returns 200' do
          subject
          expect(response.status).to eq(200)
        end

        it 'does not update item\'s body' do
          expect { subject }.not_to change { item.reload.body }
        end

        it 'does not change item count' do
          expect { subject }.not_to change { Item.count }
        end
      end
    end

    context 'when item does not exits' do
      let(:id) { 999 }
      let(:body) { 'valid test data' }

      it 'returns 404' do
        subject
        expect(response.status).to eq(404)
      end

      it 'does not change item count' do
        expect { subject }.not_to change { Item.count }
      end
    end
  end
end
