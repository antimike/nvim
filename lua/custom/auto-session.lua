local pkg = {}

function pkg.SessionName()
        local present, auto_session = pcall(require, "auto-session-library")
        local name = nil
        if present then
                name = auto_session.current_session_name
        end
        return name
end

return pkg
