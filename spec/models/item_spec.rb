require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    describe 'body validations' do
      let(:item) { build(:item, body: body) }

      context 'when body is missing' do
        let(:body) { nil }

        it 'is not valid' do
          expect(item).not_to be_valid
        end
      end

      context 'when body is an empty string' do
        let(:body) { '' }

        it 'is not valid' do
          expect(item).not_to be_valid
        end
      end

      context 'when body is a string' do
        let(:body) { Faker::Lorem.sentence }

        it 'is valid' do
          expect(item).to be_valid
        end
      end
    end

    describe 'vote_count validations' do
      let(:item) { build(:item, vote_count: vote_count) }

      context 'when vote_count is equal to 0' do
        let(:vote_count) { 0 }

        it 'is valid' do
          expect(item).to be_valid
        end
      end

      context 'when vote_count is above 0' do
        let(:vote_count) { 500 }

        it 'is valid' do
          expect(item).to be_valid
        end
      end

      context 'when vote_count is below 0' do
        let(:vote_count) { -5 }

        it 'is not valid' do
          expect(item).not_to be_valid
        end
      end
    end
  end

  describe '#upvote' do
    let!(:item) { create(:item, vote_count: vote_count) }
    let(:vote_count) { 0 }

    subject { item.upvote }

    it 'returns true' do
      expect(subject).to eq(true)
    end

    it 'increments vote_count' do
      expect { subject }.to change { item.reload.vote_count }.by(1)
    end
  end

  describe '#downvote' do
    let!(:item) { create(:item, vote_count: vote_count) }
    subject { item.downvote }

    context 'when item\'s vote_count is above 0' do
      let(:vote_count) { 5 }

      it 'returns true' do
        expect(subject).to eq(true)
      end

      it 'decrements vote_count' do
        expect { subject }.to change { item.reload.vote_count }.by(-1)
      end
    end

    context 'when item\'s vote_count is equal to 0' do
      let(:vote_count) { 0 }

      it 'returns true' do
        expect(subject).to eq(true)
      end

      it 'does not change item\'s vote_count' do
        expect { subject }.not_to change { item.reload.vote_count }
      end
    end
  end
end
