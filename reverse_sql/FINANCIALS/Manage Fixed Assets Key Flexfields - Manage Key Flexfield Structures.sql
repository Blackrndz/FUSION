/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Manage%20Key%20Flexfield%20Structures.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Manage Key Flexfield Structures.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE AS RES_KEY_FLEXFIELD_CODE
,(SELECT NAME
	FROM FND_KF_FLEXFIELDS_VL
	WHERE KEY_FLEXFIELD_CODE = KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE
	) AS RES_KEY_FLEXFIELD_NAME
/*,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID =
		(SELECT MODULE_ID
		FROM FND_KF_FLEXFIELDS_VL
		WHERE KEY_FLEXFIELD_CODE = KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE
		)
	) AS RES_MODULE*/
,KeyFlexfieldStructureEO.STRUCTURE_CODE AS RES_STRUCTURE_CODE
,KeyFlexfieldStructureEO.NAME AS RES_NAME
,KeyFlexfieldStructureEO.DESCRIPTION AS RES_DESCRIPTION
,KeyFlexfieldStructureEO.DELIMITER AS RES_DELIMITER
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = KeyFlexfieldStructureEO.ENABLED_FLAG
	) AS RES_ENABLED
,KeyFlexfieldStructureEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,KeyFlexfieldStructureEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,KeyFlexfieldStructureEO.CREATED_BY RSC_CREATED_BY
,KeyFlexfieldStructureEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_STRUCTURES_VL KeyFlexfieldStructureEO
WHERE KeyFlexfieldStructureEO.APPLICATION_ID = 140
ORDER BY RES_NAME