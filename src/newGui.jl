function launch()
    @static if Sys.isapple()
        # OpenGL 3.2 + GLSL 150
        glsl_version = 150
        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
        GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE) # 3.2+ only
        GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE) # required on Mac
    else
        # OpenGL 3.0 + GLSL 130
        glsl_version = 130
        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 0)
        # GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE) # 3.2+ only
        # GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE) # 3.0+ only
    end

    # setup GLFW error callback
    error_callback(err::GLFW.GLFWError) = @error "GLFW ERROR: code $(err.code) msg: $(err.description)"
    GLFW.SetErrorCallback(error_callback)

    # create window
    window = GLFW.CreateWindow(1280, 720, "Eye Tracking Data Converting Tool")
    @assert window != C_NULL
    GLFW.MakeContextCurrent(window)
    GLFW.SwapInterval(1)  # enable vsync

    # setup Dear ImGui context
    ctx = CImGui.CreateContext()

    # setup Dear ImGui style
    CImGui.StyleColorsLight()

    # setup Platform/Renderer bindings
    ImGui_ImplGlfw_InitForOpenGL(window, true)
    ImGui_ImplOpenGL3_Init(glsl_version)

    # Instantiate variables that are used to control input and output
    # of various widges.
    # eyeDataWindow = true
    clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
    f = Cfloat(0.0)
    # Default_files = false
    Open_CSV = false
    buf1 = "\0"^64
    # buf2 = "\0"^64
    working_directory = ""
    df = DataFrame()
    # query1 = DataFrame()

    stream_webcam = false
    # show_another_window = false
    # should_binarize_snapshot = false
    clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
    show_another_window = true
    counter = 0
    frame_count = 0


    ############################3############################### Video widege parmeter ############################3###############################
    # video_file = "C:\\Users\\Spock\\Videos\\Eye-Tracking\\Recording006.mp4"
    # draw_list = CImGui.GetWindowDrawList()
    # CImGui.GetWindowDrawList()->Ptr{ImDrawList}
    # GetWindowDrawList() = igGetWindowDrawList()

    video_file = "/Users/apple/Desktop/Eye Tracking/projects/i7cvrux/recordings/iad3hjt/segments/1/fullstream.mp4"
    # setup camera
    f = VideoIO.openvideo(video_file)
    # The OpenGL library expects RGBA UInt8 data layed out in a width x height format.
    texture₀ = ImGui_ImplOpenGL3_CreateImageTexture(f.width, f.height, format = GL_RGB)

    # Capture the first frame so that we can initialize a buffer to store each
    # frame that is read from the webcam.
    imageₙ = read(f)
    ########################################################### Video widege parmeter ###########################################################
    # INT_MAX
    while !GLFW.WindowShouldClose(window)
        GLFW.PollEvents()
        # start the Dear ImGui frame
        ImGui_ImplOpenGL3_NewFrame()
        ImGui_ImplGlfw_NewFrame()
        CImGui.NewFrame()

        begin
            CImGui.Begin("Eye Tracking")
            CImGui.Text("Please select files that you want to convert.")
            # @c CImGui.Checkbox("Default files",&Default_files)
            # @c CImGui.SliderFloat("float", &f, 0, 1)
            CImGui.Text("Please input the JSON file path:")
            CImGui.SameLine()
            # CImGui.Button(" ... ")
            #path = @cstatic buf1=""^64 CImGui.InputText("", buf1, 64)      ## Get the file path input
            CImGui.InputText("###path", buf1, length(buf1))
            first_null = findfirst(isequal('\0'),buf1)
            path = buf1[1:first_null-1]                    ## Get the file path input
            working_directory = dirname(path)
            #@show path, dirname(path)
            #CImGui.Button("Convert") && parser(path)
            if  CImGui.Button("Convert")
                df = parser(path)            ## Call JSON parser function
            end

            CImGui.SameLine()
            @c CImGui.Checkbox("Open CSV", &Open_CSV)
            if !isempty(df)
                q1 = @from i in df begin
                    @where i.GazePosX > 0
                    @select {i.Timestamp,i.GazePosX,i.GazePosY}
                    @collect DataFrame
                end
                # CSV.write("Q1_Output2",q1 )

                if Open_CSV
                    CImGui.Begin("CSV Output")
                    CImGui.SetNextWindowContentSize((1500.0, 0.0))
                    CImGui.BeginChild("##ScrollingRegion", ImVec2(0, CImGui.GetFontSize() * 20), false, CImGui.ImGuiWindowFlags_HorizontalScrollbar)
                       CImGui.Columns(34)
                       ITEMS_COUNT = nrow(df)

                       clipper = CImGui.Clipper(1)
                       clipper2 = CImGui.Clipper(ITEMS_COUNT)  # also demonstrate using the clipper for large list
                       while CImGui.Step(clipper)
                           for z = 1:34
                               df_col = names(df)[z]
                               CImGui.Text("$df_col")
                               CImGui.NextColumn()
                           end
                       end
                       while CImGui.Step(clipper2)
                           s = (CImGui.Get(clipper2, :DisplayStart))+1
                           e = (CImGui.Get(clipper2, :DisplayEnd))
                           for i = s:e, j = 1:34
                               df_val = df[j][i]
                               CImGui.Text("$df_val")
                               CImGui.IsItemHovered() && CImGui.SetTooltip(names(df)[j])
                               CImGui.NextColumn()
                           end
                       end
                       CImGui.Destroy(clipper)
                       CImGui.Destroy(clipper2)
                       CImGui.Columns(1)
                       CImGui.EndChild()
                       CImGui.End()
                 end
            end

                # CImGui.Button("Close")
                # && (eyeDataWindow = false;)                ##Try to minmise the widget when "Close" button was clicked

                CImGui.End()

                ########################################################### Video widege ###########################################################
                CImGui.Begin("Image Demo")

                if !isempty(df)
                    gp = @from i in df begin
                            @where i.GazePosX > 0
                            @select {i.Timestamp,i.GazePosX,i.GazePosY}
                            @collect DataFrame
                    end
                    # CSV.write("Q1_Output4",q1 )
                end


                col = Cfloat[1.0,1.0,0.0,1.0]
                col32 = CImGui.ColorConvertFloat4ToU32(ImVec4(col...))
                draw_list = CImGui.GetWindowDrawList()

                @c CImGui.Checkbox("Play Video", &stream_webcam)
                if stream_webcam

                    # consume the next camera frame
                    !eof(f) && read!(f, imageₙ)
                    frame_count = frame_count + 1
                    imageₙ′ = unsafe_wrap(Array{UInt8,3}, convert(Ptr{UInt8}, pointer(imageₙ)), (Cint(3), f.width, f.height))
                    ImGui_ImplOpenGL3_UpdateImageTexture(texture₀ , imageₙ′, f.width, f.height; format = GL_RGB)
                    CImGui.Image(Ptr{Cvoid}(texture₀), (f.width, f.height))
                    # @show CImGui.GetWindowPos()
                    # @show CImGui.GetWindowWidth()
                    # @show CImGui.GetWindowHeight()
                    # @show CImGui.GetContentRegionAvail()
                    # @show CImGui.GetCursorPosX()
                    # @show CImGui.GetCursorScreenPos()
                    # @show CImGui.GetTextLineHeight()
                    # @show CImGui.GetFrameHeightWithSpacing()
                    # @show CImGui.GetItemRectSize()
                    video_pos = CImGui.GetCursorScreenPos()
                    video_size = CImGui.GetItemRectSize()
                    CImGui.AddCircle(draw_list,(video_pos.x + (video_size.x)*gp[2*frame_count-1, :GazePosX],(video_pos.y- video_size.y)+(video_size.y * gp[2*frame_count-1, :GazePosY])) , 25.0, col32, 20, 7.0)
                    # CImGui.AddCircle(draw_list,(1917.0, 1148.0), 18.0, col32, 20, 5.0)
                    # CImGui.AddCircle(draw_list,(Float64(CImGui.GetCursorPosX()),Float64(CImGui.GetCursorPosY())), 18.0, col32, 20, 5.0)
                    # CImGui.AddCircle(draw_list,(1917.0*gp[2*frame_count-1, :GazePosX],1148.0*gp[2*frame_count-1, :GazePosY]), 18.0, col32, 20, 5.0)
                    sleep(0.019)

                    # CImGui.AddCircle(draw_list,(1917.0*gp[2*frame_count-1, :GazePosX],1148.0*gp[2*frame_count-1, :GazePosY]), 18.0, col32, 20, 5.0)
                end
                # end
                CImGui.End()
    ########################################################### Video widege ###########################################################
        end



        # rendering
        CImGui.Render()
        GLFW.MakeContextCurrent(window)
        display_w, display_h = GLFW.GetFramebufferSize(window)
        glViewport(0, 0, display_w, display_h)
        glClearColor(clear_color...)
        glClear(GL_COLOR_BUFFER_BIT)
        ImGui_ImplOpenGL3_RenderDrawData(CImGui.GetDrawData())

        GLFW.MakeContextCurrent(window)
        GLFW.SwapBuffers(window)
    end

    # cleanup
    ImGui_ImplOpenGL3_Shutdown()
    ImGui_ImplGlfw_Shutdown()
    CImGui.DestroyContext(ctx)

    GLFW.DestroyWindow(window)
end
