/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Set%20Assignments%20for%20Set%20Determinant%20Type%20-%20Set%20Assignments%20for%20Set%20Determinant%20Type.sql $:
 * $Id: Manage Set Assignments for Set Determinant Type - Set Assignments for Set Determinant Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT Setidreferencegrouppeo.Visible_Group_Name Res_Reference_Group_Name
,Setidsetseo2.Set_Name Res_Determinant_Value
,SetIdSetsEO.SET_NAME RES_SET_NAME
,SetIdAssignmentsEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SetIdAssignmentsEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SetIdAssignmentsEO.CREATED_BY RSC_CREATED_BY
,SetIdAssignmentsEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,SetIdAssignmentsEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_SETID_ASSIGNMENTS SetIdAssignmentsEO
,Fnd_Setid_Sets_Vl Setidsetseo
,Fnd_Setid_Sets_Vl Setidsetseo2
,FND_SETID_REFERENCE_GROUPS_VL SetIdReferenceGroupPEO
WHERE Setidassignmentseo.Set_Id               = Setidsetseo.Set_Id
AND Setidassignmentseo.DETERMINANT_VALUE      = Setidsetseo2.Set_Id
AND SetIdAssignmentsEO.REFERENCE_GROUP_NAME   = SetIdReferenceGroupPEO.REFERENCE_GROUP_NAME
AND((((Setidassignmentseo.Determinant_Type    = 'SET')))
And(((Setidassignmentseo.Determinant_Type     = 'SET'))))
Order by Setidreferencegrouppeo.Visible_Group_Name