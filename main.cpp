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

bool OnInit()
{
    window *mainWindow = new window("Template Window");
    mainWindow->Show(true);
    return true;
}
