/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Key%20Flexfield%20Structure%20Instances.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Key Flexfield Structure Instances.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FND_KF_STR_INSTANCES_VL

SELECT FndKfFlexfieldVl.KEY_FLEXFIELD_CODE AS RES_KEY_FLEXFIELD_CODE
,FndKfFlexfieldVl.NAME AS RES_KEY_FLEXFIELD_NAME
,fndkfstrinstancetl.STRUCTURE_INSTANCE_CODE       AS RES_STRUCTURE_INSTANCE_CODE
,fndkfstrinstancetl.STRUCTURE_INSTANCE_IDENTIFIER AS RES_API_NAME
,fndkfstrinstancetl.NAME                          AS RES_NAME
,fndkfstrinstancetl.DESCRIPTION                   AS RES_DESCRIPTION
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = fndkfstrinstancetl.ENABLED_FLAG
	),'No') AS RES_ENABLED
,DECODE(FndKfFlexfieldVl.DYNAMIC_COMBO_CREATION_FLAG,'Y',
	NVL((SELECT meaning
		FROM fnd_lookups
		WHERE lookup_type = 'YES_NO'
		AND lookup_code   = fndkfstrinstancetl.DYNAMIC_COMBO_CREATION_FLAG),'No')
	) AS RES_DYNAMIC_COMBINATION_CREATI
,decode(fndkfstrinstancetl.SHA_ENABLED_FLAG,'Y','Yes','No') RES_SHORTHAND_ALIAS_ENABLED
,(SELECT name
	FROM FND_KF_STRUCTURES_VL
	WHERE STRUCTURE_ID = fndkfstrinstancetl.STRUCTURE_ID
	) AS RES_STRUCTURE_NAME
,fndkfstrinstancetl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndkfstrinstancetl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndkfstrinstancetl.CREATED_BY RSC_CREATED_BY
,fndkfstrinstancetl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_FLEXFIELDS_VL FndKfFlexfieldVl
,FND_KF_STR_INSTANCES_VL fndkfstrinstancetl
WHERE FndKfFlexfieldVl.KEY_FLEXFIELD_CODE = fndkfstrinstancetl.KEY_FLEXFIELD_CODE
AND fndkfstrinstancetl.APPLICATION_ID = 140
ORDER BY RES_KEY_FLEXFIELD_CODE