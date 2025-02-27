
package AIVE_I3N;
import ij.IJ;
import ij.plugin.PlugIn;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.HashMap;


public class AIVE_I3N implements PlugIn, ActionListener
{

   //init variables
   String macroPath; 

   static JButton b1;
   static JLabel mLab, mLab1;
   static JPanel aivepan, aivepan1;

   public JPanel MakePanel()
   {
   	   JPanel aivepan = new JPanel(new GridBagLayout());

       GridBagConstraints c = new GridBagConstraints();
       c.fill = GridBagConstraints.HORIZONTAL;
       c.anchor = GridBagConstraints.PAGE_START;
       c.weightx = 0.5;
       c.insets = new Insets(5,5,5,5);

       c.gridx=0; c.gridy=0; c.gridwidth=3;
       aivepan.add(mLab = new JLabel("These are the additional macros used for AIVE I3N!",JLabel.CENTER ),c);
       mLab.setBorder(BorderFactory.createLineBorder(Color.BLACK , 2));

       JButton b1 = new JButton("Info");
       b1.addActionListener(this);
       c.gridx=1; c.gridy=1; c.gridwidth=1;
       aivepan.add(b1,c);

       c.gridx=0; c.gridy=3;
       aivepan.add(new JLabel("Membrane Prediction Macros: ",JLabel.CENTER ),c);


       JButton bMP6 = new JButton("Split Core B");
       bMP6.addActionListener(this);
       c.gridx=1; c.gridy=3;
       aivepan.add(bMP6,c);

       c.gridx=0; c.gridy=4;
       aivepan.add(new JLabel("Process Source Image: ",JLabel.CENTER ),c);

       JButton bAM4 = new JButton("CLAHE PreFilter");
       bAM4.addActionListener(this);
       c.gridx=1; c.gridy=4;
       aivepan.add(bAM4,c);


       c.gridx=0; c.gridy=5; 
       aivepan.add(new JLabel("AIVE merge: ",JLabel.CENTER ),c);
       c.gridwidth=1;

       JButton bAM3 = new JButton("I3N Merge");
       bAM3.addActionListener(this);
       c.gridx=1; c.gridy=5;
       aivepan.add(bAM3,c);

       c.gridx=0; c.gridy=7;
       aivepan.add(new JLabel("Enable Dialogue for MacOS",JLabel.CENTER ),c);

       JButton b2 = new JButton("Enable");
       b2.addActionListener(this);
       c.gridx=1; c.gridy=7;
       aivepan.add(b2,c);

       aivepan.setBackground(Color.decode("#BB91D6"));

   	   return aivepan;
   }

   public JPanel makePanel1()
   {
   	  JPanel aivepan1 = new JPanel(new GridBagLayout());

       GridBagConstraints c = new GridBagConstraints();
       c.fill = GridBagConstraints.HORIZONTAL;
       c.anchor = GridBagConstraints.PAGE_START;
       c.weightx = 0.5;
       c.insets = new Insets(5,5,5,5);
   
       c.gridx=0; c.gridy=8; c.gridwidth=3;
       aivepan1.add(mLab1 = new JLabel("Go to the main AIVE window:",JLabel.CENTER ),c);
       mLab1.setBorder(BorderFactory.createLineBorder(Color.BLACK , 2));

       JButton acp1 = new JButton("AIVE Control Panel");
       acp1.addActionListener(this);
       c.gridx=0; c.gridy=9;
       aivepan1.add(acp1,c);

       aivepan1.setBackground(Color.decode("#8ac7a3"));

       return aivepan1;
    }

   public void actionPerformed(ActionEvent e)
   {
         String name = e.getActionCommand();

         HashMap<String, String> AIVEMacros = new HashMap<String, String>();
         HashMap<String, String> AIVEInfo = new HashMap<String, String>();
         HashMap<String, String> AIVECP = new HashMap<String, String>();

        //Separate input values by command type
         AIVEInfo.put("Info", "AIVEI3NInfo.txt");

         AIVEMacros.put("Split Core B", "AI-Training/CoreBClassSplitMacro1a.ijm");
         AIVEMacros.put("CLAHE PreFilter", "VE-Processing/Pre-CLAHE-LowPassNoiseFilter.ijm");
         AIVEMacros.put("I3N Merge", "AIVE-Merge/AIVE-Merge-I3N.ijm");
         AIVEMacros.put("Enable", "JFileMacOS.ijm");

         AIVECP.put("AIVE Control Panel", "AIVE ");
  
          if (AIVEInfo.containsKey(name)==true) {
           openTxt(AIVEInfo.get(name));
          }
          if (AIVEMacros.containsKey(name)==true) {
            runMacros(AIVEMacros.get(name));
          }
          if (AIVECP.containsKey(name)==true) {
            IJ.run(AIVECP.get(name));
       }
         
    }

    public void runMacros(String name) {
         IJ.log(macroPath + name);
         IJ.runMacroFile(macroPath + name);
    }

    public void openTxt(String name) {
     IJ.open(macroPath + name);
    }


   public void run(String arg)
   {
       macroPath = System.getProperty("user.dir") + "/plugins/AIVEI3N/Macros/";

	   if (arg.equals("") || arg.equals("run"))
	   {

	     //Creates Main Panel
	   	    JFrame mainframe = new JFrame("AIVE I3N");
	   	    mainframe.setPreferredSize(new Dimension(330,300));
	   	    mainframe.setLayout(new BorderLayout());
	   	    mainframe.setResizable(true);

	     //Add buttons
	         JPanel newPanel = MakePanel();
           JPanel newPanel1 = makePanel1();

		     mainframe.add(newPanel,BorderLayout.CENTER);
         mainframe.add(newPanel1,BorderLayout.SOUTH);
         mainframe.pack();
		     mainframe.setVisible(true);

	   }
   }

}
