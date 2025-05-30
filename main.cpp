#include <wx/wx.h>

class app : public wxApp
{
public:
    bool OnInit();
};

class window : public wxFrame
{
public:
    window(const wxString &title);
};

wxIMPLEMENT_APP(app);

bool app::OnInit()
{
    window *mainWindow = new window("Test Window");
    mainWindow->Show(true);
    return true;
}

window::window(const wxString &title) : wxFrame(NULL, wxID_ANY, title)
{
}