local pkg = {}

function pkg.SessionName()
        local present, auto_session = pcall(require, "auto-session-library")
        local name = ""
        if present then
                success, val = pcall(auto_session.current_session_name)
                if success then
                        name = val
                end
        end
        return name
end

return pkg
