# Hi Matt Buland. Here is where I used everything. My score is super terrible.
# instance var - see @health_info, @look_comfort, @look
# class var - see @@look_comfort, although not a practical use of class variables. There's only ever one instance so yeah...
# constants - see PLAYER_MAX_HEALTH, PLAYER_HEAL_THRESHOLD, etc...
# array - see @look
# hash - see @health_info
# functions - see def initialize
# comments - sprinkled about

class Player

	# Constants to modify the player's behaviour. Change some too much and the player won't win
	PLAYER_MAX_HEALTH = 20
	PLAYER_HEAL_THRESHOLD = 1
	PLAYER_RUN_THRESHOLD = 9

	# Get those class and instance vars going!
	def initialize
		@health_info = { previous_health: PLAYER_MAX_HEALTH, heal_amount: 0 }
		@@look_comfort = 0
		@look = []
	end

  def play_turn(warrior)
  	# How much did my health change?
  	health_difference = warrior.health - @health_info[:previous_health] - @health_info[:heal_amount]
  	@heal_amount = 0

  	# Woah dude, there's a wall literally right in front of me. Better turn around
  	if warrior.feel.wall?
  		warrior.pivot!
  		return
  	end

  	# Nothing in front of me...
    if warrior.feel.empty?
    	# Better look ahead and see what's going on
    	if @look.empty?
    		@look = warrior.look

    		# Is there nothing? If so I'm a bit more confident to move more...
    		totally_empty = true
    		for space in @look
  				if !space.empty?
  					totally_empty = false
  				end
    		end
    		if totally_empty
    			@look_comfort += 1
    		end

    	# I've already looked and seen what's going on 
    	else

    		# Is there an enemy in front of me?
    		enemy_present = false
    		for space in @look
    			if space.enemy?
    				enemy_present = true
    			end
    		end

    		# Am I being shot by and archer? That is so annoying
    		if health_difference <= -3 and health_difference > -11

    			# Is he ahead of me?...
    			archer_ahead = false
    			for space in @look
    				if space.unit != nil and space.unit.is_a? RubyWarrior::Units::Archer
    					archer_ahead = true
    				end
    			end

    			# He's behind me! Turn around! Better look again after I do too!
    			if !archer_ahead
    				warrior.pivot!
    				@look.clear

    			# He's ahead! Get shooting!!
    			else
    				warrior.shoot!
    			end

    		# I'm pretty hurt and I'm getting worse. I should bail, so long as my back's not to a wall. Better look around afterwards too
	    	elsif warrior.health < PLAYER_RUN_THRESHOLD and health_difference <= -3 and warrior.feel(:backward).empty?
	    			warrior.walk!(:backward)
	    			@look.clear

	    	# I'm doing okay and not getting badly hurt so I'm going to shoot!
	    	elsif 
	    		enemy_present
    			warrior.shoot!

    		# I'm hurt and there's no one around hurting me, so I'll heal.
	    	elsif warrior.health < PLAYER_HEAL_THRESHOLD and health_difference >= 0
	    			warrior.rest!
	    			@health_info[:heal_amount] = 2

	    	# There's no one around and I'm feeling good, let's take a stroll
	  		else
	  			warrior.walk!

	  			# There's no one for miles! I feel confident enough to move some more
	  			@@look_comfort -= 1
	  			if @@look_comfort <= 1
	  				@look.clear
	  			end
	  		end
			end
    else

    	#There's a prisoner in front of me, better save them.
    	if warrior.feel.captive?
    		warrior.rescue!

    	# There's an enemy! Attack!
    	else
    		warrior.attack!
    	end
    end

    #I'd better remember how I'm feeling before I get attacked.
 	 	@health_info[:previous_health] = warrior.health
  end
end
