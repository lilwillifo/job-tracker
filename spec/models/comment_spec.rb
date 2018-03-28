require 'rails_helper'

describe Comment do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without content" do
        comment = Comment.new
        expect(comment).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with content" do
        job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
        comment = job.comments.new(content: 'comment content')
        expect(comment).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a job" do
      comment = Comment.new(content: 'commenty content comment')
      expect(comment).to respond_to(:job)
    end
  end

  describe 'class methods' do
    it '.time_format' do
      comment = Comment.new(content: 'commenty content comment', created_at: Time.now)

      expected = comment.created_at.strftime("%b %d, %Y %k:%M %P")

      expect(comment.time_format).to eq(expected)
    end
  end
end
