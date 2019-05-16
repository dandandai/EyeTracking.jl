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
    working_directory = ""
    df = DataFrame()
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
            CImGui.Text("Please input the file path:")
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
            # if !isempty(df)
            #     Base.display(df[1,1])
            # end
            CImGui.SameLine()
            @c CImGui.Checkbox("Open CSV", &Open_CSV)
            if !isempty(df)
                # Base.display(df[1,1])
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
        end

        # show a simple window that we create ourselves.
        # we use a Begin/End pair to created a named window.
        # @cstatic f=Cfloat(0.0) counter=Cint(0) begin
        #    CImGui.Begin("Hello, world!")  # create a window called "Hello, world!" and append into it.
        #    CImGui.Text("This is some useful text.")  # display some text
        #    @c CImGui.Checkbox("Demo Window", &show_demo_window)  # edit bools storing our window open/close state
        #    @c CImGui.Checkbox("Another Window", &show_another_window)

        #    @c CImGui.SliderFloat("float", &f, 0, 1)  # edit 1 float using a slider from 0 to 1
        #    CImGui.ColorEdit3("clear color", clear_color)  # edit 3 floats representing a color
        #    CImGui.Button("Button") && (counter += 1)

        #    CImGui.SameLine()
        #    CImGui.Text("counter = $counter")
        #    CImGui.Text(@sprintf("Application average %.3f ms/frame (%.1f FPS)", 1000 / CImGui.GetIO().Framerate, CImGui.GetIO().Framerate))

        #    CImGui.End()
        # end

        # show another simple window.
        # if show_another_window
        #    @c CImGui.Begin("Another Window", &show_another_window)  # pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        #    CImGui.Text("Hello from another window!")
        #    CImGui.Button("Close Me") && (show_another_window = false;)
        #    CImGui.End()
        # end

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
