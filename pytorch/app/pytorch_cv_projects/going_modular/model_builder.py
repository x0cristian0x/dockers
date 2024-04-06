"""
Contains PyTorch model code to instantiate a TinyVGG model.
"""
import torch
from torch import nn 

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        # Input Block
        self.convblock1 = nn.Sequential(
            nn.Conv2d(in_channels=3, out_channels=8, kernel_size=3, padding=0, bias=False),
            nn.ReLU(),
            nn.BatchNorm2d(8)) 
        
        self.pool11 = nn.MaxPool2d(2, 2)

        # CONVOLUTION BLOCK 1
        self.convblock2 = nn.Sequential(
            nn.Conv2d(in_channels=8, out_channels=16, kernel_size=3, padding=0, bias=False),
            nn.ReLU(),
            nn.BatchNorm2d(16)) 

        self.pool22 = nn.MaxPool2d(2, 2) 

        self.convblock3 = nn.Sequential(
            nn.Conv2d(in_channels=16, out_channels=10, kernel_size=1, padding=0, bias=False),
            nn.ReLU(),
            nn.BatchNorm2d(10)) 
        
        self.pool33 = nn.MaxPool2d(2, 2) 
        
        # CONVOLUTION BLOCK 2
        self.convblock4 = nn.Sequential(
            nn.Conv2d(in_channels=10, out_channels=10, kernel_size=3, padding=0, bias=False),
            nn.ReLU(),            
            nn.BatchNorm2d(10))

        self.convblock5 = nn.Sequential(
            nn.Conv2d(in_channels=10, out_channels=32, kernel_size=1, padding=0, bias=False),
            nn.ReLU(),
            nn.BatchNorm2d(32)) 

        self.convblock6 = nn.Sequential(
            nn.Conv2d(in_channels=32, out_channels=10, kernel_size=1, padding=0, bias=False),
            nn.ReLU(),            
            nn.BatchNorm2d(10))

        self.convblock7 = nn.Sequential(
            nn.Conv2d(in_channels=10, out_channels=10, kernel_size=3, padding=0, bias=False),
            nn.ReLU(),            
            nn.BatchNorm2d(10))

        self.convblock8 = nn.Sequential(
            nn.Conv2d(in_channels=10, out_channels=32, kernel_size=1, padding=0, bias=False),
            nn.ReLU(),
            nn.BatchNorm2d(32))

        self.convblock9 = nn.Sequential(
            nn.Conv2d(in_channels=32, out_channels=10, kernel_size=1, padding=0, bias=False),
            nn.ReLU(),            
            nn.BatchNorm2d(10)) 

        self.convblock10 = nn.Sequential(
            nn.Conv2d(in_channels=10, out_channels=14, kernel_size=3, padding=0, bias=False),
            nn.ReLU(),            
            nn.BatchNorm2d(14)) 

        self.convblock11 = nn.Sequential(
            nn.Conv2d(in_channels=14, out_channels=16, kernel_size=3, padding=0, bias=False),
            nn.ReLU(),            
            nn.BatchNorm2d(16)) 
        
        # OUTPUT BLOCK
        self.gap = nn.Sequential(
            nn.AvgPool2d(kernel_size=4)) 

        self.convblockout = nn.Sequential(
              nn.Conv2d(in_channels=16, out_channels=2, kernel_size=4, padding=0, bias=False)) 

    def forward(self, x):
        x = self.convblock1(x)
        x = self.pool11(x)
        x = self.convblock2(x)
        x = self.pool22(x)
        x = self.convblock3(x)
        x = self.pool33(x)
        x = self.convblock4(x)
        x = self.convblock5(x)
        x = self.convblock6(x)
        x = self.convblock7(x)
        x = self.convblock8(x)
        x = self.convblock9(x)
        x = self.convblock10(x)
        x = self.convblock11(x)
        x = self.gap(x)        
        x = self.convblockout(x)

        x = x.view(-1, 2)
        return nn.functional.log_softmax(x, dim=-1)
