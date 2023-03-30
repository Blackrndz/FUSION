/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Assign%20Business%20Unit%20Business%20Function%20-%20Financial%20Reporting.sql $:
 * $Id: Assign Business Unit Business Function - Financial Reporting.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select distinct Head.NAME RES_BUSINESS_UNIT_NAME
,Head.NAME2 RES_PRIMARY_LEDGER
,decode(Head.ORG_INFORMATION9,'Y','Yes','No') RES_BELOW_LEGAL_ENTITY
,Head.NAME1 RES_DEFAULT_LEGAL_ENTITYLEGAL_ 
,Head.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Head.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Head.CREATED_BY  RSC_CREATED_BY
,Head.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,Head.ORGANIZATION_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,Head.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT BusinessUnitEO.NAME,
	XleEntityProfiles.NAME AS NAME1,
	GlLedgers.NAME AS NAME2,
	BusinessUnitDetailEO.ORG_INFORMATION9,
	BusinessUnitEO.ORGANIZATION_ID  ,
	BusinessUnitDetailEO.BUSINESS_GROUP_ID,
	BusinessUnitDetailEO.LAST_UPDATED_BY ,
	BusinessUnitDetailEO.LAST_UPDATE_DATE,
	BusinessUnitDetailEO.CREATED_BY ,
	BusinessUnitDetailEO.CREATION_DATE
	FROM Fusion.HR_ORGANIZATION_V BusinessUnitEO, 
	Fusion.HR_ORG_DETAILS_BY_CLASS_V BusinessUnitDetailEO, 
	Fusion.XLE_ENTITY_PROFILES XleEntityProfiles, 
	Fusion.GL_LEDGERS GlLedgers, 
	Fusion.FUN_FIN_BUSINESS_UNITS_V FinancialsBusinessUnitPEO,
	Fusion.FND_SETID_SETS_VL SetIdSetPEO,
	Fusion.HR_LOCATIONS_ALL_F_VL LocationDPEO,
	Fusion.PER_PERSON_NAMES_F_V PersonNameDPEO
	WHERE (BusinessUnitEO.ORGANIZATION_ID            = BusinessUnitDetailEO.ORGANIZATION_ID)
	AND (BusinessUnitEO.CLASSIFICATION_CODE          = BusinessUnitDetailEO.CLASSIFICATION_CODE)
	AND BusinessUnitDetailEO.ORG_INFORMATION_CONTEXT = BusinessUnitEO.CLASSIFICATION_CODE
	AND BusinessUnitEO.CLASSIFICATION_CODE           = 'FUN_BUSINESS_UNIT'
	AND (BusinessUnitDetailEO.ORG_INFORMATION2       = XleEntityProfiles.LEGAL_ENTITY_ID(+))
	AND (BusinessUnitDetailEO.ORG_INFORMATION3       = GlLedgers.LEDGER_ID(+))
	AND (BusinessUnitDetailEO.ORG_INFORMATION7       = FinancialsBusinessUnitPEO.BU_ID(+))
	AND (BusinessUnitDetailEO.ORG_INFORMATION4       = SetIdSetPEO.SET_ID(+))
	AND (BusinessUnitEO.LOCATION_ID                  = LocationDPEO.LOCATION_ID(+))
	AND (BusinessUnitDetailEO.ORG_INFORMATION1       = PersonNameDPEO.PERSON_ID(+))
	) Head
,Fusion.FUN_BU_USAGES BusinessUnitUsageEO
Where BusinessUnitUsageEO.BUSINESS_UNIT_ID = Head.ORGANIZATION_ID(+)
order by Head.NAME