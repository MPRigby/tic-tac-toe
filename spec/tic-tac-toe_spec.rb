#spec/tic-tac-toe_spec.rb
require "tic-tac-toe"

describe Board do
  subject do
    Board.new
  end
  input_error_message = "Invalid input. input must be two characters: 1 row letter and 1 column number."

    describe ".format_input" do
      context "when input contains only 1 of A-C first and only 1 of 1-3 second" do
        it "outputs array of row and column numbers" do
          expect(subject.format_input("A1")).to eql([0,0])
          expect(subject.format_input("C3")).to eql([2,2])
        end
      end
      context "when input contains only 1 of 1-3 first and only 1 of A-C second" do
        it "outputs array of row and column numbers" do
          expect(subject.format_input("2B")).to eql([1,1])
          expect(subject.format_input("3A")).to eql([0,2])
        end
      end
      context "when input contains lowercase a-c" do
        it "outputs array of row and column numbers" do
          expect(subject.format_input("a1")).to eql([0,0])
          expect(subject.format_input("c3")).to eql([2,2])
        end
      end
      context "when input contains more or less than 2 characters" do
        it "outputs error" do
          expect(subject.format_input("ab3")).to eql(input_error_message)
          expect(subject.format_input("a12")).to eql(input_error_message)
          expect(subject.format_input("B")).to eql(input_error_message)
        end
      end
      context "when input contains character other than A-C and 1-3" do
        it "outputs error" do
          expect(subject.format_input("f3")).to eql(input_error_message)
          expect(subject.format_input("a7")).to eql(input_error_message)
          expect(subject.format_input("B!")).to eql(input_error_message)
        end
      end
      context "when input does not contain 1 of A-C and 1 of 1-3" do
        it "outputs error" do
          expect(subject.format_input("BB")).to eql(input_error_message)
          expect(subject.format_input("33")).to eql(input_error_message)
        end
      end
      context "when input points to already occupied location" do
        it "outputs error" do
          subject.place_token('X', 0, 0)
          subject.place_token('O', 2, 0)
          subject.place_token('X', 2, 2)
          expect(subject.format_input("A1")).to eql("There is already a token on that space.")
          expect(subject.format_input("C1")).to eql("There is already a token on that space.")
          expect(subject.format_input("C3")).to eql("There is already a token on that space.")
        end
      end
    end

    describe ".check_win" do
      context "when no tokens have been played" do
        it "returns continue" do
          expect(subject.check_win).to eql('continue')
        end
      end

      context "when 3 tokens are in same column but are not the same" do
        it "returns continue" do
          subject.place_token('X', 0, 0)
          subject.place_token('O', 1, 0)
          subject.place_token('X', 2, 0)
          subject.place_token('O', 1, 1)
          subject.place_token('X', 0, 1)
          subject.place_token('X', 2, 1)
          expect(subject.check_win).to eql('continue')
        end
      end
      context "when 3 tokens are in same row but are not the same" do
        it "returns continue" do
          subject.place_token('X', 0, 0)
          subject.place_token('X', 0, 1)
          subject.place_token('O', 0, 2)
          subject.place_token('X', 1, 2)
          subject.place_token('O', 1, 0)
          subject.place_token('O', 1, 1)
          expect(subject.check_win).to eql('continue')
        end
      end
      context "when 3 tokens are in diagonal but are not the same" do
        it "returns continue" do
          subject.place_token('X', 0, 0)
          subject.place_token('X', 2, 0)
          subject.place_token('O', 1, 1)
          subject.place_token('O', 0, 2)
          subject.place_token('O', 2, 2)
          expect(subject.check_win).to eql('continue')
        end
      end
      context "when 3 X tokens are in random spots" do
        it "returns continue" do
          subject.place_token('X', 0, 0)
          subject.place_token('X', 2, 0)
          subject.place_token('X', 1, 1)
          expect(subject.check_win).to eql('continue')
        end
        it "returns continue won" do
          subject.place_token('X', 1, 1)
          subject.place_token('X', 0, 2)
          subject.place_token('X', 2, 2)
          expect(subject.check_win).to eql('continue')
        end
      end
      context "when 3 O tokens are in random spots" do
        it "returns continue" do
          subject.place_token('O', 0, 0)
          subject.place_token('O', 2, 0)
          subject.place_token('O', 1, 1)
          expect(subject.check_win).to eql('continue')
        end
        it "returns continue" do
          subject.place_token('O', 1, 1)
          subject.place_token('O', 0, 2)
          subject.place_token('O', 2, 2)
          expect(subject.check_win).to eql('continue')
        end
      end
      context "when 3 X tokens are in one column" do
        it "returns 'X' won" do
          subject.place_token('X', 0, 0)
          subject.place_token('X', 1, 0)
          subject.place_token('X', 2, 0)
          expect(subject.check_win).to eql('X')
        end
        it "returns 'X' won" do
          subject.place_token('X', 0, 2)
          subject.place_token('X', 1, 2)
          subject.place_token('X', 2, 2)
          expect(subject.check_win).to eql('X')
        end
      end
      context "when 3 X tokens are in one row" do
        it "returns 'X' won" do
          subject.place_token('X', 0, 0)
          subject.place_token('X', 0, 1)
          subject.place_token('X', 0, 2)
          expect(subject.check_win).to eql('X')
        end
        it "returns 'X' won" do
          subject.place_token('X', 2, 0)
          subject.place_token('X', 2, 1)
          subject.place_token('X', 2, 2)
          expect(subject.check_win).to eql('X')
        end
      end
      context "when 3 X tokens are in diagonal" do
        it "returns 'X' won" do
          subject.place_token('X', 0, 0)
          subject.place_token('X', 2, 2)
          subject.place_token('X', 1, 1)
          expect(subject.check_win).to eql('X')
        end
        it "returns 'X' won" do
          subject.place_token('X', 1, 1)
          subject.place_token('X', 0, 2)
          subject.place_token('X', 2, 0)
          expect(subject.check_win).to eql('X')
        end
      end
      context "when 3 O tokens are in one column" do
        it "returns 'O' won" do
          subject.place_token('O', 0, 0)
          subject.place_token('O', 1, 0)
          subject.place_token('O', 2, 0)
          expect(subject.check_win).to eql('O')
        end
        it "returns 'O' won" do
          subject.place_token('O', 0, 2)
          subject.place_token('O', 1, 2)
          subject.place_token('O', 2, 2)
          expect(subject.check_win).to eql('O')
        end
      end
      context "when 3 O tokens are in one row" do
        it "returns 'O' won" do
          subject.place_token('O', 0, 0)
          subject.place_token('O', 0, 1)
          subject.place_token('O', 0, 2)
          expect(subject.check_win).to eql('O')
        end
        it "returns 'O' won" do
          subject.place_token('O', 2, 0)
          subject.place_token('O', 2, 1)
          subject.place_token('O', 2, 2)
          expect(subject.check_win).to eql('O')
        end
      end
      context "when 3 O tokens are in diagonal" do
        it "returns 'O' won" do
          subject.place_token('O', 0, 0)
          subject.place_token('O', 2, 2)
          subject.place_token('O', 1, 1)
          expect(subject.check_win).to eql('O')
        end
        it "returns 'O' won" do
          subject.place_token('O', 1, 1)
          subject.place_token('O', 0, 2)
          subject.place_token('O', 2, 0)
          expect(subject.check_win).to eql('O')
        end
      end
      context "when 9 tokens have been played, with no winner" do
        it "returns draw" do
          subject.place_token('X', 0, 0)
          subject.place_token('O', 1, 0)
          subject.place_token('X', 2, 0)
          subject.place_token('O', 1, 1)
          subject.place_token('X', 0, 1)
          subject.place_token('O', 0, 2)
          subject.place_token('X', 2, 1)
          subject.place_token('O', 2, 2)
          subject.place_token('X', 1, 2)
          expect(subject.check_win).to eql('draw')
        end
      end
    end

    context "when game has not been played" do
      it "prints empty board" do
        expect{subject.print_board}.to output("   1   2   3\nA ___|___|___\nB ___|___|___\nC    |   |   \n").to_stdout
      end
    end

    context "when given new tokens" do
      it "updates @board_state" do
        subject.place_token('X', 0, 0)
        subject.place_token('O', 1, 2)
        subject.place_token('X', 2, 0)
        expect{subject.print_board}.to output("   1   2   3\nA _X_|___|___\nB ___|___|_O_\nC  X |   |   \n").to_stdout
      end
    end

end
