require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # You need to write this method
  score = 0
  counts = [0] * 6

  dice.each do |value|
    counts[value -1] += 1 # We count number of each value such as 1,2,3,4 etc. So then count[0] will store count of ones
  end

  if counts[0] >=3 # If count of ones is greather or equal to 3, we adding 1000 points to our score
    score += 1000
    counts[0] -= 3 #Then we substract 3, because we already count points of three ones
  end

  (1..6).each do |i|
      if counts[4] >= 4
        score += 550
        counts[4] -= 4
      end
      if counts[i-1] >= 3 # Checking if there some othere three of number other than ones
        score += (i) * 100 # Increment index because it starts with 0, but dice value start with 1. Then multiply to 100 to get points to score correctly
        counts[i-1] - 3 #Then we substract 3, because we already count points of those three numbers
      end 
  end
  
  if counts[0] > 0 && counts[0] < 3
    score += counts[0] * 100 # we get counts of ones that we have, and multiply to * 100
    counts[0] - 1
  end
  
  if counts[4] > 0 && counts[4] < 3
    score += counts[4] * 50 # we get counts of fives that we have, and multiply to * 50
    counts[4] - 1
  end 
  
  return score
end


class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
