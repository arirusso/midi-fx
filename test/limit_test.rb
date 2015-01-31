require "helper"

class MIDIFX::LimitTest < Minitest::Test

  def test_numeric_range
    message = MIDIMessage::NoteOn["C0"].new(0, 100)
    assert_equal(12, message.note)
    MIDIFX::Limit.new(:note, 30).process(message)
    assert_equal(30, message.note)
  end

  def test_low_note
    message = MIDIMessage::NoteOn["C0"].new(0, 100)
    assert_equal(12, message.note)
    MIDIFX::Limit.new(:note, (20..50)).process(message)
    assert_equal(20, message.note)
  end

  def test_high_note
    message = MIDIMessage::NoteOn["C6"].new(0, 100)
    assert_equal(84, message.note)
    MIDIFX::Limit.new(:note, (20..50)).process(message)
    assert_equal(50, message.note)
  end

  def test_low_velocity
    message = MIDIMessage::NoteOn["C0"].new(0, 10)
    assert_equal(10, message.velocity)
    MIDIFX::Limit.new(:velocity, (30..110)).process(message)
    assert_equal(30, message.velocity)
  end

  def test_high_velocity
    message = MIDIMessage::NoteOn["C6"].new(0, 120)
    assert_equal(120, message.velocity)
    MIDIFX::Limit.new(:velocity, (25..75)).process(message)
    assert_equal(75, message.velocity)
  end

end
