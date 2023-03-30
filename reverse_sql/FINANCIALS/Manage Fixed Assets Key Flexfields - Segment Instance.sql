/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Segment%20Instance.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Segment Instance.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT fndKFInstanceE0.KEY_FLEXFIELD_CODE AS RES_KEY_FLEXFIELD_CODE
,fndKFValuesE0.NAME AS RES_KEY_FLEXFIELD_NAME
/*,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID =
		(SELECT MODULE_ID
		FROM FND_KF_FLEXFIELDS_VL
		WHERE KEY_FLEXFIELD_CODE =
			(SELECT KEY_FLEXFIELD_CODE
			FROM FND_KF_STR_INSTANCES_VL
			WHERE STRUCTURE_INSTANCE_ID = fndKfSegmentInstances.STRUCTURE_INSTANCE_ID
			)
		)
	) AS RES_MODULE*/
,fndKFInstanceE0.STRUCTURE_INSTANCE_CODE AS RES_STRUCTURE_INSTANCE_CODE
,fndKFInstanceE0.NAME AS RES_NAME
/*,(SELECT name
	FROM FND_KF_STRUCTURES_VL
	WHERE STRUCTURE_ID =
		(SELECT STRUCTURE_ID
		FROM FND_KF_STR_INSTANCES_VL
		WHERE STRUCTURE_INSTANCE_ID = fndKfSegmentInstances.STRUCTURE_INSTANCE_ID
		)
	)                                  AS RES_STRUCTURE_NAME*/
,fndKfSegmentInstances.SEGMENT_CODE AS RES_SEGMENT_CODE
,(SELECT VALUE_SET_CODE
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = fndKfSegmentInstances.VALUE_SET_ID
	) AS RES_VALUE_SET_CODE
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = fndKfSegmentInstances.REQUIRED_FLAG
	),'No') AS RES_REQUIRED
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = fndKfSegmentInstances.DISPLAY_FLAG
	),'No') AS RES_DISPLAYED
,DECODE(fndKFValuesE0.BI_ENABLED_FLAG,'Y',NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = fndKfSegmentInstances.BI_ENABLED_FLAG
	),'No')) AS RES_BI_ENABLED
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_KF_SEGMENT_DEFAULT_TYPES'
	AND LOOKUP_CODE   = fndKfSegmentInstances.DEFAULT_TYPE
	)                                   AS RES_DEFAULT_TYPE
,fndKfSegmentInstances.DEFAULT_VALUE AS RES_DEFAULT_VALUE
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_KF_SEGMENT_QUERY_REQ_TYPES'
	AND LOOKUP_CODE   = fndKfSegmentInstances.QUERY_REQUIRED_TYPE
	) AS RES_QUERY_REQUIRED
	--,TREE_STRUCTURE_CODE
,fndKfSegmentInstances.TREE_CODE AS RES_TREE_NAME
,fndKfSegmentInstances.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndKfSegmentInstances.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndKfSegmentInstances.CREATED_BY RSC_CREATED_BY
,fndKfSegmentInstances.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_SEGMENT_INSTANCES fndKfSegmentInstances
,FND_KF_FLEXFIELDS_VL fndKFValuesE0
,FND_KF_STR_INSTANCES_VL fndKFInstanceE0
WHERE fndKfSegmentInstances.STRUCTURE_INSTANCE_ID IN
	(SELECT STRUCTURE_INSTANCE_ID
	FROM FND_KF_STR_INSTANCES_VL
	WHERE APPLICATION_ID = 140
	)
AND fndKFInstanceE0.STRUCTURE_INSTANCE_ID = fndKfSegmentInstances.STRUCTURE_INSTANCE_ID
AND fndKFValuesE0.KEY_FLEXFIELD_CODE = fndKFInstanceE0.KEY_FLEXFIELD_CODE
ORDER BY RES_KEY_FLEXFIELD_CODE