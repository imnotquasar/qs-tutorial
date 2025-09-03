Config = {}

Config.Speed = 5000 -- Start tutorial ms

Config.Locations = { -- Locations, texts and images
    {
        coords = vector3(-647.00, -760.28, 284.39),
        heading =  263.50,
        image = "talk3.png",
        text = "Welcome to Quasar Roleplay, where reality distorts and shadows whisper secrets. Here, dreams and wakefulness intertwine... Are you ready to wake up?",
        button = 'Continue',
        vibrate = true
    },
    {
        coords = vector3(-240.76, -997.58, 34.11),
        heading = 35.20,
        image = "rose.png",
        text = "Here, between coffee-stained papers and empty stares, the most valuable thing is traded: time for money. If you need a job, this is your altar. Pray, sign, and prepare to sell your hours to the highest bidder.",
        button = 'Continue',
        vibrate = true
    },
    {
        coords = vector3(408.89, -962.64, 28.13),
        heading = 239.08,
        image = "point.png",
        text = "The cathedral of law, where heroes and villains drink the same stale coffee. Here, fates are decided with a pen and a raised eyebrow. If you walk in on your own, you might leave. If they bring you in, pray it's just a fine.",
        button = 'Continue',
        vibrate = false
    },
    {
        coords = vector3(258.90, -598.08, 50.41),
        heading = 292.67,
        image = "talk3.png",
        text = "The butcher's temple, where white coats hide trembling hands and sharp scalpels. You enter broken and leave with more questions than answers. If you wake up with something extra or missing a kidney, it's best not to ask too many questions.",
        button = 'Continue',
        vibrate = true
    },
    {
        coords = vector3(33.53, -1348.26, 21.83),
        heading = 59.94,
        image = "talk2.png",
        text = "The 24/7 stores, neon-lit temples where insomnia and desperation meet in aisles of canned food. Here, you can buy anything: from a questionable snack to the perfect excuse for an improvised heist. Don’t ask about the clerk, he’s seen it all.",
        button = 'Continue',
        vibrate = false
    },
    {
        coords = vector3(119.97, -1285.13, 20.29),
        heading = 109.93,
        image = "marry.png",
        text = "The Vanilla Unicorn, where dense smoke and neon lights hide more than just skin. Here, love is a transaction, and broken hearts are just another part of the business. A word of advice: never fall for a dancer... unless you enjoy losing more than just money.",
        button = 'Enter the world',
        vibrate = false
    },
}

Config.Commands = { -- Comand list
    StartTutorial = 'tutorial',
    ResetTutorial = 'resettutorial'
}

Config.Hud = { -- Hud configuration
    Enable = function()
        -- DisplayRadar(true) -- Enables radar display on HUD
        -- exports['qs-interface']:ToggleHud(true) -- Uncomment if using an external HUD
    end,
    Disable = function()
        -- DisplayRadar(false) -- Disables radar display on HUD
        -- exports['qs-interface']:ToggleHud(false) -- Uncomment if using an external HUD
    end
}

Config.Debug = false -- Debug Configuration, enables detailed print logs for debugging; leave off for production