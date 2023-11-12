new_stagenum = 1

function load_stage_after_trans()
    stagenum = new_stagenum
    reinit_stages() 
    initialize_stage()
end