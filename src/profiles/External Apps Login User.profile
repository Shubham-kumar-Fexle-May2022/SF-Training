<?xml version="1.0" encoding="UTF-8"?>
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <classAccesses>
        <apexClass>DistrictTriggerHandler</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>StateTriggerHandler</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <custom>false</custom>
    <fieldPermissions>
        <editable>false</editable>
        <field>District__c.District_Pin_Code__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>District__c.Identification__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>State__c.Identification__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>State__c.State_Code__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>State__c.Total_Districts__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <tabVisibilities>
        <tab>District__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>State__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <userLicense>External Apps Login</userLicense>
    <userPermissions>
        <enabled>true</enabled>
        <name>EnableNotifications</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>SelectFilesFromSalesforce</name>
    </userPermissions>
</Profile>
