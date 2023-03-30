/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=673##RES##IBY_FORMATS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 

SELECT IbyFormatsVl.FORMAT_NAME RES_NAME
,IbyFormatsVl.FORMAT_CODE RES_CODE
,IbyFormatsVl.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,IbyFormatsVl.ATTRIBUTE1
,IbyFormatsVl.ATTRIBUTE2
,IbyFormatsVl.ATTRIBUTE3
,IbyFormatsVl.ATTRIBUTE4
,IbyFormatsVl.ATTRIBUTE5
,IbyFormatsVl.ATTRIBUTE6
,IbyFormatsVl.ATTRIBUTE7
,IbyFormatsVl.ATTRIBUTE8
,IbyFormatsVl.ATTRIBUTE9
,IbyFormatsVl.ATTRIBUTE10
,IbyFormatsVl.ATTRIBUTE11
,IbyFormatsVl.ATTRIBUTE12
,IbyFormatsVl.ATTRIBUTE13
,IbyFormatsVl.ATTRIBUTE14
,IbyFormatsVl.ATTRIBUTE15
,IbyFormatsVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,IbyFormatsVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,IbyFormatsVl.CREATED_BY RSC_CREATED_BY
,IbyFormatsVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_FORMATS_VL IbyFormatsVl
WHERE(IbyFormatsVl.ATTRIBUTE_CATEGORY IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE1            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE2            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE3            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE4            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE5            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE6            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE7            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE8            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE9            IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE10           IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE11           IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE12           IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE13           IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE14           IS NOT NULL
OR IbyFormatsVl.ATTRIBUTE15           IS NOT NULL)
ORDER BY IbyFormatsVl.FORMAT_NAME
,IbyFormatsVl.FORMAT_CODE