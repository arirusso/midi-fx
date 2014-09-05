require "helper"

class MIDIFX::TransposeTest < Test::Unit::TestCase

  def test_transpose_note_up
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    MIDIFX::Transpose.new(:note, 5).process(message)
    assert_equal(65, message.note)
  end

  def test_transpose_velocity_up
    message = MIDIMessage::NoteOn["C4"].new(0, 82)
    assert_equal(82, message.velocity)
    MIDIFX::Transpose.new(:velocity, 10).process(message)
    assert_equal(92, message.velocity)
  end

  def test_transpose_note_down
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    MIDIFX::Transpose.new(:note, -5).process(message)
    assert_equal(55, message.note)
  end

  def test_transpose_velocity_down
    message = MIDIMessage::NoteOn["C4"].new(0, 82)
    assert_equal(82, message.velocity)
    MIDIFX::Transpose.new(:velocity, -10).process(message)
    assert_equal(72, message.velocity)
  end

end
